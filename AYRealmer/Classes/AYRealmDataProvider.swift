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
import AYDataBaser

//MARK: - AYRealmDataProvider protocol
public protocol AYRealmDataProvider: AYDataProvider {
  mutating func objects<AYModel: AYRealmConvertibleModel>() -> [AYModel]
  mutating func object<AYModel: AYRealmConvertibleModel, Identifier>(id: Identifier) -> AYModel?

  mutating func add<AYModel: AYRealmConvertibleModel>(model: AYModel) -> Bool
  mutating func update<AYModel: AYRealmConvertibleModel>(model: AYModel) -> Bool

  mutating func remove<AYModel: AYRealmConvertibleModel, Identifier>(id: Identifier, type: AYModel.Type) -> Bool
  mutating func remove<AYModel: AYRealmConvertibleModel>(model: AYModel) -> Bool
  mutating func removeAll<AYModel: AYRealmConvertibleModel>(type: AYModel.Type) -> Bool

  mutating func dropDataBase() -> Bool
}
