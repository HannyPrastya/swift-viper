//
//  Request+debug.swift
//  Challenge
//
//  Created by Hanny Prastya Hariyadi on 2020/12/13.
//

import Alamofire

extension Request {
   public func debug() -> Self {
      #if DEBUG
         print(self)
      #endif
      return self
   }
}
