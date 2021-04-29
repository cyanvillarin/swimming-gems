//
//  CustomTextField.swift
//  Happisa
//
//  Created by CYAN on 2021/02/06.
//

import UIKit

class CustomTextView: UITextView {
   
   let padding = UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
   
   /// called when initialized programatically
   override init(frame: CGRect, textContainer: NSTextContainer?) {
      super.init(frame: frame, textContainer: textContainer)
      self.setup()
   }
   
   /// called when initialized via interface builder
   required public init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      self.setup()
   }
   
   private func setup() {
      self.delegate = self
      self.backgroundColor = .clear
      self.layer.masksToBounds = true
      self.layer.cornerRadius = 5.0
      self.textContainerInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
   }
   
}

extension CustomTextView: UITextViewDelegate {
   /// when return is clicked, the keyboard will hide
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      self.resignFirstResponder()
      return true
   }
}
