//
//  ViewController.swift
//  SideMenuDemo
//
//  Created by Nilesh's MAC on 9/29/17.
//  Copyright © 2017 Nilesh's MAC. All rights reserved.
//

import UIKit

class ViewController: BaseViewController,ColorBlockViewDelegate {
    func colorBlockDidSelect(color: UIColor) {
        print("color: \(color)")
        colorButton.backgroundColor = color
    }
    
    func colorBlockDidClose() {
        print("close")
    }
    
    @IBAction func showCircularView(_ sender: UIButton) {
        let blockView = self.view.showColorBlockView(onTap: sender)
        blockView.delegate = self
        blockView.setCustomColor(to: .down, color: .green)
        blockView.setCustomColor(to: .right, color: .blue)
        blockView.setCustomColor(to: .up, color: .yellow)
        blockView.setCustomColor(to: .left, color: .red)
    }
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var servicesCollectionView: UICollectionView!
    @IBOutlet weak var pagingView: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var menServiceView: UIView!
    @IBOutlet weak var womenServiceView: UIView!
    @IBOutlet weak var packagesView: UIView!
    @IBOutlet weak var colorButton: UIButton!
    
    //MARK:- Variables
    var productInfoDict: [ProductItem]!
    var serviceInfoDict: [ServicesItem]!
    var mainScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSlideMenuButton()
        setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let when = DispatchTime.now() + 0.3 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            // Your code with delay
            self.addScrollView()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI()
    {
        productInfoDict = [ProductItem.init(itemName: "Home Services", itemImage: #imageLiteral(resourceName: "salon")), ProductItem.init(itemName: "All Salons", itemImage: #imageLiteral(resourceName: "salon")),ProductItem.init(itemName: "Offers", itemImage: #imageLiteral(resourceName: "salon")),ProductItem.init(itemName: "Packages", itemImage: #imageLiteral(resourceName: "salon")),ProductItem.init(itemName: "Gifts", itemImage: #imageLiteral(resourceName: "salon")),ProductItem.init(itemName: "Blog", itemImage: #imageLiteral(resourceName: "salon"))]
        
        serviceInfoDict = [ServicesItem.init(itemName: "Body", itemImage: #imageLiteral(resourceName: "salon")), ServicesItem.init(itemName: "Face", itemImage: #imageLiteral(resourceName: "salon")), ServicesItem.init(itemName: "Nails", itemImage: #imageLiteral(resourceName: "salon")),ServicesItem.init(itemName: "Massage", itemImage: #imageLiteral(resourceName: "salon")),ServicesItem.init(itemName: "Tattoo", itemImage: #imageLiteral(resourceName: "salon")),ServicesItem.init(itemName: "Barber", itemImage: #imageLiteral(resourceName: "salon"))]
        
        productCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
        servicesCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func addScrollView()
    {
        var x:CGFloat = 0
        mainScrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: pagingView.frame.height))
        mainScrollView.isPagingEnabled = true
        mainScrollView.showsHorizontalScrollIndicator = false
        mainScrollView.bounces = false
        let images=["images2.jpeg","images3.jpeg","images4.jpeg"]
        for image in images
        {
            let imageView = UIImageView(image: UIImage(named: image))
            let scrollView = SlideShow(image: imageView, scrollFrame: CGRect(x: x, y: 0, width: UIScreen.main.bounds.size.width, height: pagingView.frame.height))
            mainScrollView.addSubview(scrollView)
            x = x + UIScreen.main.bounds.size.width
            mainScrollView.contentSize=CGSize.init(width: x, height: self.mainScrollView.frame.size.height)
        }
        
        mainScrollView.contentOffset = CGPoint.init(x: 0, y: 0)
        mainScrollView.delegate = self
        pageControl.currentPage = 0
        pagingView.addSubview(mainScrollView)
        pagingView.bringSubview(toFront: pageControl)
        menServiceView.isHidden = false
        pagingView.bringSubview(toFront: menServiceView)
        Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(moveToNextPage), userInfo: nil, repeats: true)
    }

    @objc func moveToNextPage()
    {
        let pageWidth:CGFloat = self.mainScrollView.frame.width
        let maxWidth:CGFloat = pageWidth * 3
        let contentOffset:CGFloat = self.mainScrollView.contentOffset.x
        var slideToX = contentOffset + pageWidth
        if  contentOffset + pageWidth == maxWidth
        {
            slideToX = 0
        }
        self.mainScrollView.scrollRectToVisible(CGRect(x:slideToX, y:0, width:pageWidth, height:self.mainScrollView.frame.height), animated: true)
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage: CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        if Int(currentPage) == 0{
            menServiceView.isHidden = false
            pagingView.bringSubview(toFront: menServiceView)
            packagesView.isHidden = true
            womenServiceView.isHidden = true
        }else if Int(currentPage) == 1{
            womenServiceView.isHidden = false
            pagingView.bringSubview(toFront: womenServiceView)
            menServiceView.isHidden = true
            packagesView.isHidden = true
        }else if Int(currentPage) == 2{
            packagesView.isHidden = false
            pagingView.bringSubview(toFront: packagesView)
            menServiceView.isHidden = true
            womenServiceView.isHidden = true
        }else{

        }
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth:CGFloat = scrollView.frame.width
        let currentPage: CGFloat = floor((scrollView.contentOffset.x-pageWidth/2)/pageWidth)+1
        
        if Int(currentPage) == 0{
            menServiceView.isHidden = false
            pagingView.bringSubview(toFront: menServiceView)
            packagesView.isHidden = true
            womenServiceView.isHidden = true
        }else if Int(currentPage) == 1{
            womenServiceView.isHidden = false
            pagingView.bringSubview(toFront: womenServiceView)
            menServiceView.isHidden = true
            packagesView.isHidden = true
        }else if Int(currentPage) == 2{
            packagesView.isHidden = false
            pagingView.bringSubview(toFront: packagesView)
            menServiceView.isHidden = true
            womenServiceView.isHidden = true
        }else{
            
        }
        // Change the indicator
        self.pageControl.currentPage = Int(currentPage)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(collectionView == self.productCollectionView) {
            return productInfoDict.count
        } else {
            return serviceInfoDict.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if(collectionView == self.productCollectionView) {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCell", for: indexPath) as! ProductCollectionViewCell
            let productInfo = productInfoDict[indexPath.row]
            cell.prodImageView.image = productInfo.itemImage
            cell.productNameLbl.text = productInfo.itemName
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ServicesCell", for: indexPath) as! ServicesCollectionViewCell
            let serviceInfo = serviceInfoDict[indexPath.row]
            cell.serviceImageView.image = serviceInfo.itemImage
            cell.serviceNameLbl.text = serviceInfo.itemName
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellHeight = collectionView.bounds.height
        if(collectionView == self.servicesCollectionView) {
            
            return CGSize(width: 174, height: cellHeight-2.5)
        }
        
        return CGSize(width: 132, height: cellHeight-10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if(collectionView == self.servicesCollectionView) {
            
            return UIEdgeInsetsMake(2, 0, 0, 0)
        }
        return UIEdgeInsetsMake(12, 0, 0, 0)
    }
}

struct ServicesItem {
    var itemName: String = ""
    var itemImage: UIImage = #imageLiteral(resourceName: "CameraIcon")
    
    init(itemName: String, itemImage: UIImage) {
        self.itemName = itemName
        self.itemImage = itemImage
    }
}

struct ProductItem {
    var itemName: String = ""
    var itemImage: UIImage = #imageLiteral(resourceName: "CameraIcon")
    
    init(itemName: String, itemImage: UIImage) {
        self.itemName = itemName
        self.itemImage = itemImage
    }
}

public class SlideShow: UIScrollView, UIScrollViewDelegate {
    
    public var imageView = UIImageView()

    // MARK: - Life cycle
    
    init(image: UIImageView, scrollFrame: CGRect) {
        
        super.init(frame: scrollFrame)
        
        //image.setToImageView(imageView)
        imageView = image
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        // UIScrollView(frame: bounds)
        delegate = self
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backgroundColor = UIColor.black
        // contentSize = imageView.bounds.size
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //contentOffset = CGPoint(x: 1000, y: 450)
        
        addSubview(imageView)
        
        // setZoomScale()
        
        //setupGestureRecognizer()
        
    }
    
    
    func setupGestureRecognizer() {
        let doubleTap = UITapGestureRecognizer(target: self, action: Selector(("handleDoubleTap:")))
        doubleTap.numberOfTapsRequired = 2
        addGestureRecognizer(doubleTap)
    }
    
    func handleDoubleTap(recognizer: UITapGestureRecognizer) {
        
        if (zoomScale > minimumZoomScale) {
            setZoomScale(minimumZoomScale, animated: true)
        } else {
            setZoomScale(maximumZoomScale, animated: true)
        }
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override public func layoutSubviews() {
        setZoomScale()
        //setZoomScale(minimumZoomScale, animated: false)
    }
    
    
    public func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        
        return imageView
        
    }
    
    
    func setZoomScale() {
        let imageViewSize = imageView.bounds.size
        let scrollViewSize = bounds.size
        let widthScale = scrollViewSize.width / imageViewSize.width
        let heightScale = scrollViewSize.height / imageViewSize.height
        
        minimumZoomScale = min(widthScale, heightScale)
        zoomScale = 1.0
    }
    
    public func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let imageViewSize = imageView.frame.size
        let scrollViewSize = bounds.size
        
        let verticalPadding = imageViewSize.height < scrollViewSize.height ? (scrollViewSize.height - imageViewSize.height) / 2 : 0
        let horizontalPadding = imageViewSize.width < scrollViewSize.width ? (scrollViewSize.width - imageViewSize.width) / 2 : 0
        
        scrollView.contentInset = UIEdgeInsets(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
    }
}
