//
//  CircularView.swift
//  SideMenuDemo
//
//  Created by Nilesh's MAC on 10/28/17.
//  Copyright © 2017 Nilesh's MAC. All rights reserved.
//

import UIKit

@objc public protocol ColorBlockViewDelegate
{
    func colorBlockDidSelect(color: UIColor)
    @objc optional func colorBlockDidClose()
}

class CircularView: UIView {

    public enum BlockType {
        case up
        case right
        case down
        case left
    }
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak private var centerCloseBtn: UIButton!
    @IBOutlet weak private var upBlockBtn: UIButton!
    @IBOutlet weak private var downBlockBtn: UIButton!
    @IBOutlet weak private var leftBlockBtn: UIButton!
    @IBOutlet weak private var rightBlockBtn: UIButton!
    
    var delegate: ColorBlockViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        loadNib()
    }
    
    private func loadNib()
    {
        Bundle.main.loadNibNamed("CircularView", owner: self, options: nil)
        contentView.frame = self.bounds
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = self.bounds.width / 2
        contentView.layer.borderWidth = 4
        contentView.layer.borderColor = UIColor.white.cgColor
        //contentView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner] //for bottom corners
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        addSubview(contentView)
        makeRoundedCenterBtn()
    }
    
    private func makeRoundedCenterBtn() {
        centerCloseBtn.backgroundColor = .white
        centerCloseBtn.layer.cornerRadius = centerCloseBtn.frame.width / 2
        centerCloseBtn.transform = CGAffineTransform(rotationAngle: -0.81)
    }
    
    private func closeView(_ sender: UIButton!) {
        self.transform = CGAffineTransform(rotationAngle: 2.36)
        UIView.animate(withDuration: 0.6, animations: {
            if let color = sender?.backgroundColor {
                self.setSelectedColor(color)
            }
            self.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        }) { (sucess) in
            self.removeFromSuperview()
        }
        if sender == nil {
            delegate?.colorBlockDidClose!()
        }else {
            delegate?.colorBlockDidSelect(color: sender.backgroundColor!)
        }
    }
    
    private func setSelectedColor(_ color:UIColor) {
        upBlockBtn.backgroundColor = color
        downBlockBtn.backgroundColor = color
        rightBlockBtn.backgroundColor = color
        leftBlockBtn.backgroundColor = color
    }
    
    public func setCustomColor(to blockType: BlockType, color: UIColor)
    {
        switch blockType {
        case .up:
            upBlockBtn.backgroundColor = color
        case .down:
            downBlockBtn.backgroundColor = color
        case .right:
            rightBlockBtn.backgroundColor = color
        case .left:
            leftBlockBtn.backgroundColor = color
        }
    }
    
    @IBAction private func centerCloseBtnTapped(_ sender: UIButton) {
        closeView(nil)
    }
    
    @IBAction private func upBlockBtnTapped(_ sender: UIButton) {
        closeView(sender)
    }

    @IBAction private func downBlockBtnTapped(_ sender: UIButton) {
        closeView(sender)
    }
    
    @IBAction private func rightBlockBtnTapped(_ sender: UIButton) {
        closeView(sender)
    }
    
    @IBAction private func leftBlockBtnTapped(_ sender: UIButton) {
        closeView(sender)
    }
}

extension UIView {
    func showColorBlockView(onTap sender: UIButton) -> CircularView
    {
        let xPoint = sender.frame.origin.x + (sender.frame.width/2)
        let yPoint = sender.frame.origin.y + (sender.frame.height/2)
        
        let circularView = CircularView.init(frame: CGRect(x: xPoint-50, y: yPoint-50, width: 100, height: 100))
        
        circularView.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        
        circularView.backgroundColor = UIColor.clear
        circularView.layer.shadowColor = UIColor.lightGray.cgColor
        circularView.layer.shadowOffset = CGSize(width: 0, height: 0)
        circularView.layer.shadowOpacity = 1
        circularView.layer.shadowRadius = 6.0
        circularView.layer.shadowPath = UIBezierPath(roundedRect: circularView.layer.bounds, cornerRadius: circularView.bounds.width / 2).cgPath
        
        self.addSubview(circularView)
        
        UIView.animate(withDuration: 0.6, animations: {
            circularView.transform = CGAffineTransform(rotationAngle: -2.36)
        }) { (sucess) in
            
        }
        
        return circularView
    }
}
