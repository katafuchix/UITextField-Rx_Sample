//
//  UITextField+Rx.swift
//  UITextField+Rx
//
//  Created by cano on 2021/05/16.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UITextField {

   public var delegate: DelegateProxy<UITextField, UITextFieldDelegate> {
      return RxTextFieldDelegateProxy.proxy(for: base)
   }

   public var editingDidEnd: Observable<String> {
      return delegate.sentMessage(#selector(UITextFieldDelegate.textFieldDidEndEditing(_:))).map { value in
         guard let textField = value[0] as? UITextField else { return "" }
         return textField.text!   }
   }

    public var textFieldDidBeginEditing: Observable<String> {
       return delegate.sentMessage(#selector(UITextFieldDelegate.textFieldDidBeginEditing(_:))).map { value in
          guard let textField = value[0] as? UITextField else { return "" }
          return textField.text!   }
    }
}

class RxTextFieldDelegateProxy: DelegateProxy<UITextField, UITextFieldDelegate>, DelegateProxyType, UITextFieldDelegate {

  init(textField: UITextField) {
     super.init(parentObject: textField, delegateProxy: RxTextFieldDelegateProxy.self)
  }

  static func registerKnownImplementations() {
     self.register { RxTextFieldDelegateProxy(textField: $0)}
  }

  static func currentDelegate(for object: UITextField) -> UITextFieldDelegate? {
     return object.delegate
  }

  static func setCurrentDelegate(_ delegate: UITextFieldDelegate?, to object: UITextField) {
        object.delegate = delegate
     }
}
