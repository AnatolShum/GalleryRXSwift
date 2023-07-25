//
//  DetailController.swift
//  GalleryRXSwift
//
//  Created by Anatolii Shumov on 21/07/2023.
//

import UIKit
import SDWebImage

class DetailViewController: UIViewController {
    
    let largeImageURL: String
    
    init(largeImageURL: String) {
        self.largeImageURL = largeImageURL
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var scrollView: UIScrollView!
    
    let largeImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        setImage()
    }
    
    func setUI() {
        view.backgroundColor = .white
        scrollView = UITableView(frame: view.bounds)
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        view.addSubview(scrollView)
        largeImageView.frame = scrollView.bounds
        scrollView.addSubview(largeImageView)
        
        centerScrollViewContents()
    }
    
    func setImage() {
        let url = URL(string: largeImageURL)
        largeImageView.sd_setImage(with: url, placeholderImage: nil, options: [.continueInBackground, .progressiveLoad])
    }

}

extension DetailViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return largeImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        centerScrollViewContents()
    }
    
    func centerScrollViewContents() {
        let boundsSize = scrollView.bounds.size
        var contentFrame = largeImageView.frame
        
        if contentFrame.size.width < boundsSize.width {
            contentFrame.origin.x = (boundsSize.width - contentFrame.size.width) / 2.0
        } else {
            contentFrame.origin.x = 0
        }
        
        if contentFrame.size.height < boundsSize.height {
            contentFrame.origin.y = (boundsSize.height - contentFrame.size.height) / 2.0
        } else {
            contentFrame.origin.y = 0
        }
        
        largeImageView.frame = contentFrame
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            resetZoomScale()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        resetZoomScale()
    }
    
    func resetZoomScale() {
        UIView.animate(withDuration: 0.3) {
            self.scrollView.zoomScale = self.scrollView.minimumZoomScale
            self.centerScrollViewContents()
        }
    }
}
