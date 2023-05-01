//
//  GamePageView.swift
//  game-news-app
//
//  Created by Milan Parađina on 30.04.2023..
//

import UIKit

class GamePageView: UIView {
    var contentWidth: CGFloat
    var contentHeight: CGFloat
    
    var index = 0
    
    var pageViewOne = OnboardingView(image: UIImage(systemName: Text.UIImages.logoViewImageGameController)!, title: Text.UIStrings.onboardingTitleOne, infoDescription: Text.UIStrings.onboardingTextOne)
    var pageViewTwo = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageTwo)!, title: Text.UIStrings.onboardingTitleTwo, infoDescription: Text.UIStrings.onboardingTextTwo)
    var pageViewThree = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageThree)!, title: Text.UIStrings.oboardingTitleThree, infoDescription: Text.UIStrings.onboardingTextThree)
    var pageViewFour = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageFour)!, title: Text.UIStrings.onboardingTitleFour, infoDescription: Text.UIStrings.onboardingTextFour)
    var pageViewFive = OnboardingView(image: UIImage(systemName: Text.UIImages.onboardingImageFive)!, title: Text.UIStrings.onboardingTitleFive, infoDescription: Text.UIStrings.onboardingTextFive)


     lazy var views: [OnboardingView] = [pageViewOne, pageViewTwo, pageViewThree, pageViewFour, pageViewFive]
    
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

    init(contentWidth: CGFloat, contentHeight: CGFloat) {
        self.contentWidth = contentWidth
        self.contentHeight = contentHeight
        super.init(frame: .zero)
        layout()
    }
    private func layout() {
        backgroundColor = Colors.backgroundColor
        addSubview(scrollView)
        addSubview(pageControl)
        //Int(frame.size.width)
        scrollView.snp.makeConstraints { make in
//            make.top.left.right.equalToSuperview()
            make.edges.equalToSuperview()
            make.height.equalTo(200)
//            make.width.equalTo(contentWidth * CGFloat(views.count))
            
        }
        scrollView.contentSize = CGSize(width: Int(contentWidth) * views.count, height: 200)

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
    
    func update()  {
        index = index + 1
        let x = CGFloat(index) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x, y:0), animated: true)
    }
}


