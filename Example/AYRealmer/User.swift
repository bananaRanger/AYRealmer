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

// MARK: - Entity
class UserEntity: Object, AYRealmConvertibleEntity {
  typealias Model = User

  @objc dynamic var email = String()
  @objc dynamic var fullName = String()

  var model: User { Model(with: self) }

  override static func primaryKey() -> String? { return "email" }
  
  required convenience init(with model: User) {
    self.init()
    self.email = model.email
    self.fullName = model.fullName
  }
}

// MARK: - Model
struct User: AYRealmConvertibleModel {
  typealias Entity = UserEntity
  
  var email = String()
  var fullName = String()

  var entity: UserEntity { Entity(with: self) }
  
  init() { }
  
  init(with entity: Entity) {
    self.email = entity.email
    self.fullName = entity.fullName
  }
}
