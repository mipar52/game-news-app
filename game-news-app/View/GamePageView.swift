//
//  GamePageView.swift
//  game-news-app
//
//  Created by Milan Parađina on 30.04.2023..
//

import UIKit

class GamePageView: UIView {
    
    var pageViewOne = OnboardingView(image: UIImage(systemName: Text.UIImages.logoViewImageGameController)!, title: "Using the application", infoDescription: "This is a very strange app that does really strange app stuff, do not reccomend")
    var pageViewTwo = OnboardingView(image: UIImage(systemName: Text.UIImages.logoViewImageGameController)!, title: "Using the loloz", infoDescription: "This is a very strange app that does really strange app stuff, do not reccomend")
    var pageViewThree = OnboardingView(image: UIImage(systemName: Text.UIImages.logoViewImageGameController)!, title: "Using the application", infoDescription: "This is a very strange app that does really strange app stuff, do not reccomend")
    var pageViewFour = OnboardingView(image: UIImage(systemName: Text.UIImages.logoViewImageGameController)!, title: "Using the application", infoDescription: "This is a very strange app that does really strange app stuff, do not reccomend")
    var pageViewFive = OnboardingView(image: UIImage(systemName: Text.UIImages.logoViewImageGameController)!, title: "Using the application", infoDescription: "This is a very strange app that does really strange app stuff, do not reccomend")


     lazy var views: [OnboardingView] = [pageViewOne, pageViewTwo, pageViewThree, pageViewFour]
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = true
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

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    private func layout() {
        backgroundColor = Colors.textColor
        addSubview(scrollView)
        addSubview(pageControl)
        
        scrollView.contentSize = CGSize(width: Int(frame.size.width) * views.count, height: 200) //Int(frame.size.width)
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        

        for i in 0..<views.count {
            scrollView.addSubview(views[i])
            let viewOffset = frame.size.width * CGFloat(i)

            views[i].snp.makeConstraints { make in
                make.width.equalToSuperview()
                make.height.equalTo(200)
                make.left.equalToSuperview().offset(viewOffset)
//                make.top.bottom.equalToSuperview()
//                make.left.equalToSuperview().offset(viewOffset)
//                make.width.equalToSuperview()
//                make.height.equalTo(200)
//                make.left.equalToSuperview().offset(viewOffset)
//                make.trailing.equalToSuperview().offset(viewOffset)
//                make.top.bottom.equalTo(scrollView)
//                make.left.right.equalTo(scrollView.frame.width * CGFloat(i))
//            make.width.height.equalToSuperview().offset(24)
//                make.leading.equalTo(scrollView.snp.leading).offset(self.frame.width + CGFloat(i))
//                make.trailing.equalTo(scrollView.snp.trailing).offset(self.frame.width + CGFloat(i))
            }
        }
        
        pageControl.snp.makeConstraints { make in
          //  make.center.equalTo(scrollView.snp.center)
            make.bottom.equalTo(scrollView.snp.bottom)//.offset(10)
            make.centerX.equalTo(scrollView.snp.centerX)
        }
                
        addShadow(off: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
    }
    
}
extension GamePageView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x / frame.width)
        pageControl.currentPage = Int(pageIndex)
//        if pageControl.currentPage > 2 {
//            pageControl.currentPage = 0
//        }
    }
}


