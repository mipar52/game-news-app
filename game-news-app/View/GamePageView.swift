//
//  GamePageView.swift
//  game-news-app
//
//  Created by Milan Parađina on 30.04.2023..
//

import UIKit
import SnapKit

class GamePageView: UIView {
    var contentWidth: CGFloat
    let views: [UIView]
        
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        
        scrollView.contentSize = CGSize(width: contentWidth * CGFloat(views.count), height: 200)
    
        scrollView.delegate = self
        return scrollView
    }()
        
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = views.count
        pageControl.currentPage = 0
        pageControl.addTarget(self, action: #selector(pageControlerSwipe(sender:)), for: .touchUpInside)
        return pageControl
        
    }()
    
    @objc private func pageControlerSwipe(sender: UIPageControl) {
        print("swipe")
        scrollView.scrollToView(horizontalPage: sender.currentPage, animated: true)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    init(contentWidth: CGFloat, views: [UIView]) {
        self.contentWidth = contentWidth
        self.views = views
        super.init(frame: .zero)
        layout()
    }
    
    private func layout() {
        backgroundColor = Colors.backgroundColor
        addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(200)
        }
        
        for i in 0..<views.count {
            scrollView.addSubview(views[i])
            let viewOffset = contentWidth * CGFloat(i)
            
            print("view offset: \(viewOffset)")
            views[i].snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(200)
                make.left.equalToSuperview().offset(viewOffset)
            }
        }
        addSubview(pageControl)

        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(scrollView.snp.bottom)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
                
        addShadow(off: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
    }
}

extension GamePageView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    override var intrinsicContentSize: CGSize {
        print(views.first!.frame.width * CGFloat(views.count))
        return CGSize(width: views.first!.frame.width * CGFloat(views.count), height: 200)
    }
}

//MARK: Additional helper methods to assist with auto-layout of the scrollview
extension GamePageView {
    
    func reconfigureViews() {
        if views.count != 0 {
            for i in 0..<views.count {
                let offset = views[i].frame.width * CGFloat(i)
                views[i].snp.makeConstraints { make in
                    print("New offset: \(offset)")
                    make.width.equalToSuperview()
                    make.height.equalTo(200)
                    make.left.equalToSuperview().offset(offset)
                }
                views[i].layoutIfNeeded()
            }
        }
    }
    
    func resizeScrollViewContentSize() {
        var contentRect = CGRect.zero
        var width: CGFloat = .zero
        for view in self.scrollView.subviews {
            if view is UIPageControl {
                print(view.frame.width)
            } else {
                width += view.frame.width
            }
        }
        let finalWidth = Int(width)
        print(finalWidth)
        self.scrollView.layoutIfNeeded()
        self.scrollView.contentSize = CGSize(width: finalWidth, height: 200)
    }
}
