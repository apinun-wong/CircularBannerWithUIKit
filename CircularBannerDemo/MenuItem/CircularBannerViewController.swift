//
//  CircularBannerViewController.swift
//  CircularBannerDemo
//
//  Created by Apinun Wongintawang on 3/2/2569 BE.
//

import UIKit

class CircularBannerViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    var items: [BannerItem] = [
        .init(number: 1, color: .red),
        .init(number: 2, color: .blue),
        .init(number: 3, color: .systemPink),
        .init(number: 4, color: .purple)
    ]
    private var isFirstLayout = true

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.register(UINib(nibName: "CircularBannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CircularBannerCollectionViewCell")
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if isFirstLayout && !items.isEmpty {
            isFirstLayout = false
            let middleIndex = items.count
            let indexPath = IndexPath(item: middleIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
        }
    }
}

extension CircularBannerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count * 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CircularBannerCollectionViewCell", for: indexPath) as? CircularBannerCollectionViewCell {
            cell.setUp(item: items[indexPath.row % items.count])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !items.isEmpty else { return }
        
        /// คำนวณความกว้างของข้อมูล 1 ชุด (Original Set)
        /// เช่น ถ้ามี [1, 2, 3, 4] และแต่ละอันกว้างเท่าหน้าจอ -> oneSetWidth = 4 * screenWidth
        let screenWidth = UIScreen.main.bounds.width
        let oneSetWidth = screenWidth * CGFloat(items.count)
        
        /// ตรวจสอบตำแหน่งการเลื่อน (Scroll Offset)
        /// เรามีข้อมูล 3 ชุดต่อกัน: [Set 1] [Set 2 (Main)] [Set 3]
        /// จุดประสงค์คือพยายามเลี้ยงให้ User อยู่ใน [Set 2] เสมอ
        
        if scrollView.contentOffset.x >= oneSetWidth * 2 {
            // กรณีเลื่อนขวา: ทะลุออกจาก Set 2 ไปเข้า Set 3
            // ดีดกลับมาที่ตำแหน่งเดียวกันใน Set 2 (ลบออก 1 ช่วงตัว)
            // User จะไม่รู้สึกว่ามีการกระตุก เพราะภาพที่เห็นเหมือนกันเป๊ะ
            scrollView.contentOffset.x -= oneSetWidth
        } else if scrollView.contentOffset.x < oneSetWidth {
            // กรณีเลื่อนซ้าย: ถอยออกจาก Set 2 ไปเข้า Set 1
            // ดีดไปข้างหน้าเข้าสู่ Set 2 (บวกเพิ่ม 1 ช่วงตัว)
            scrollView.contentOffset.x += oneSetWidth
        }
    }
}

extension CircularBannerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        return CGSize(width: screenWidth, height: 128)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

struct BannerItem {
    var number: Int
    var color: UIColor
}
