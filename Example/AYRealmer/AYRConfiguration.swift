// MIT License
//
// Copyright (c) 2019 Anton Yereshchenko
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import Foundation
import AYRealmer

// MARK: - Configuration
enum AYRConfiguration: String, AYDataBaseConfiguration {
  case user = "db_user"
  
  var name: String { return rawValue }
  
  var version: UInt64 {
    switch self {
    case .user:
      return 0
    }
  }
  
  var fileName: String? { return nil }
  
  var types: [AYConvertible.Type] {
    switch self {
    case .user:
      return [UserEntity.self]
    }
  }
  
  func migration(_ migration: Migration, _ oldSchemaVersion: UInt64) {
    switch self {
    case .user:
      print("\(name) migration")
    }
  }
}
