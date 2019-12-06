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
import RealmSwift
import AYDataBaser

//MARK: - AYRealmer struct
public struct AYRealmer: AYRealmDataProvider {
  //MARK: - properties
  
  ///
  /// Current database configuration
  ///
  public var configuration: Realm.Configuration
  
  lazy var realm: Realm = {
    return try! Realm(configuration: configuration)
  }()

  ///
  /// Realmer constructor method
  ///
  /// - Parameters:
  ///     - configuration: Database configuration object that has to be confirming to protocol *DataBaseConfiguration*
  ///     - folder: Folder with database file location
  ///
  public init(with configuration: AYDataBaseConfiguration,
              in folder: AYFileManagerFolder? = .library) {
    self.configuration = Realm.Configuration.create(
      with: configuration,
      in: folder ?? .library
    )
  }

  //MARK: - methods

  ///
  /// Return list of models with specific type
  ///
  public mutating func objects<AYModel: AYRealmConvertibleModel>() -> [AYModel] {
    let elements = self.elements(of: AYModel.AYEntity.self)
    return [AYModel](elements.compactMap { entity -> AYModel? in
      return (entity.model as? AYModel) ?? nil
    })
  }

  ///
  /// Return specific model with specific type
  ///
  /// - Parameters:
  ///     - id: entity's *primaryKey*
  ///
  public mutating func object<AYModel: AYRealmConvertibleModel>(id: String) -> AYModel? {
    let element = self.element(AYModel.AYEntity.self, by: id)
    return element?.model as? AYModel
  }

  ///
  /// Add model to database for storing
  ///
  /// - Parameters:
  ///     - model: object for storing
  /// - Returns: operation result
  ///
  @discardableResult
  public mutating func add<AYModel: AYRealmConvertibleModel>(model: AYModel) -> Bool {
    return add(element: model.entity, update: .all)
  }

  ///
  /// Update exist model in database
  ///
  /// - Parameters:
  ///     - model: object for updating
  /// - Returns: operation result
  ///
  @discardableResult
  public mutating func update<AYModel: AYRealmConvertibleModel>(model: AYModel) -> Bool {
    return add(element: model.entity, update: .modified)
  }

  ///
  /// Remove model from database with specific *id* and *type*
  ///
  /// - Parameters:
  ///     - id: *primaryKey* for removing
  ///     - type: model's type for removing
  /// - Returns: operation result
  ///
  @discardableResult
  public mutating func remove<AYModel: AYRealmConvertibleModel>(id: String, type: AYModel.Type) -> Bool {
    guard let element =
      element(type.AYEntity.self, by: id) else { return false }
    return delete(element: element)
  }

  ///
  /// Remove model from database
  ///
  /// - Parameters:
  ///     - model: model for removing
  /// - Returns: operation result
  ///
  @discardableResult
  public mutating func remove<AYModel: AYRealmConvertibleModel>(model: AYModel) -> Bool {
    guard let id = type(of: model).AYEntity.primaryKey(),
      let value = model.entity.value(forKey: id) as? String else { return false }
    return remove(id: value, type: type(of: model))
  }
  
  ///
  /// Remove all models from database with specific *type*
  ///
  /// - Parameters:
  ///     - type: model's type 'for removing
  /// - Returns: operation result
  ///
  @discardableResult
  public mutating func removeAll<AYModel: AYRealmConvertibleModel>(type: AYModel.Type) -> Bool {
    let objects = elements(of: type.AYEntity.self)
    return delete(elements: objects)
  }
  
  ///
  /// Clean up all data from database
  ///
  /// - Parameters:
  ///     - type: model's type 'for removing
  /// - Returns: operation result
  ///
  public mutating func dropDataBase() -> Bool {
    return cleanUp()
  }
}

//MARK: - CRUD extension
extension AYRealmer {
  mutating func element<Element: Object>(by id: String) -> Element? {
    return realm.object(ofType: Element.self, forPrimaryKey: id)
  }
  
  mutating func element<Element: Object>(_ type: Element.Type, by id: String) -> Element? {
    return realm.object(ofType: type, forPrimaryKey: id)
  }
  
  mutating func elements<Element: Object>(of type: Element.Type) -> Results<Element> {
    return realm.objects(type)
  }
  
  mutating func add(element: Object, update: Realm.UpdatePolicy = .modified) -> Bool {
    do {
      try realm.write {
        realm.add(element, update: update)
      }
      return true
    } catch {
      return false
    }
  }
  
  mutating func delete(element: Object) -> Bool {
    do {
      try realm.write {
        realm.delete(element)
      }
      return true
    } catch {
      return false
    }
  }
  
  mutating func delete<Element: Object>(elements: Results<Element>) -> Bool {
    do {
      try realm.write {
        realm.delete(elements)
      }
      return true
    } catch {
      return false
    }
  }
  
  mutating func cleanUp() -> Bool {
    do {
      try realm.write {
        realm.deleteAll()
      }
      return true
    } catch {
      return false
    }
  }
}

