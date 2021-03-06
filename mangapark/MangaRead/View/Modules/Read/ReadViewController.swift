//
//  MangaReadViewController.swift
//  MangaRead
//
//  Created by gem on 7/10/20.
//  Copyright © 2020 gem. All rights reserved.
//

import UIKit
import SDWebImage

class ReadViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var btnNext: UIButton!
    @IBOutlet weak var lbPage: UILabel!
    @IBOutlet weak var btnPrev: UIButton!
    @IBOutlet var swipeLeft: UISwipeGestureRecognizer!
    @IBOutlet var swipeRight: UISwipeGestureRecognizer!
    
    var arrImage: [String] = []
    var url = ""
    let getData = GetData()
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 5.0
        getData.fetchMangaImage(url: url, callback: addImage(image:))
        btnPrev.addTarget(self, action: #selector(prevPage), for: .touchUpInside)
        btnNext.addTarget(self, action: #selector(nextPage), for: .touchUpInside)
        swipeLeft.addTarget(self, action: #selector(nextPage))
        scrollView.addGestureRecognizer(swipeLeft)
        swipeRight.addTarget(self, action: #selector(prevPage))
        scrollView.addGestureRecognizer(swipeRight)
        if arrImage.isEmpty {
            lbPage.text = "0/0"
        }
    }
    
    func addImage(image: [String]) {
        arrImage = image
        reload()
    }
    
    func reload() {
        img.sd_setImage(with: URL(string: arrImage[0]))
        lbPage.text = "\(currentPage + 1)/\(arrImage.count)"
    }
    
    @objc func prevPage() {
        if currentPage > 0 {
            currentPage -= 1
            lbPage.text = "\(currentPage + 1)/\(arrImage.count)"
            img.sd_setImage(with: URL(string: arrImage[currentPage]))
        }
    }
    
    @objc func nextPage() {
        if currentPage < arrImage.count - 1 {
            currentPage += 1
            lbPage.text = "\(currentPage + 1)/\(arrImage.count)"
            img.sd_setImage(with: URL(string: arrImage[currentPage]))
        }
    }
}

extension ReadViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.img
    }
}
