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

//MARK: - AYFileManagerPathError
public enum AYFileManagerFolder {
  case library
  case documents
  case bundle
}

//MARK: - AYFileManagerPathError
public enum AYFileManagerPathError: Error, LocalizedError {
  case notFound
  
  public var errorDescription: String? {
    switch self {
    case .notFound: return "Resource not found"
    }
  }
}

//MARK: - FileManager extension
public extension FileManager {

  static func url(for folder: AYFileManagerFolder, with name: String) throws -> URL {
    switch folder {
    case .library:    return try libary(pathWith: name)
    case .documents:  return try documents(pathWith: name)
    case .bundle:     return try bundle(pathWith: name)
    }
  }
  
  /// Store your files in Library folder if you don’t want to automatically back up
  /// it to iCloud.
  static func libary(pathWith name: String) throws -> URL {
    return try FileManager.default
      .url(for: .libraryDirectory,
           in: .userDomainMask,
           appropriateFor: nil,
           create: false)
      .appendingPathComponent(name)
  }
  
  /// Storing files in the Documents folder gives your app a couple of free features:
  /// the files are automatically backed up to the user’s iCloud storage, and can also
  /// be easily backed up by the user using iTunes, making the files easily accessible.
  ///
  /// However, Apple traditionally recommends storing your app’s files in the Library
  /// folder, and not the Documents folder.
  static func documents(pathWith name: String) throws -> URL {
    return try FileManager.default
      .url(for: .documentDirectory,
           in: .userDomainMask,
           appropriateFor: nil,
           create: false)
      .appendingPathComponent(name)
  }
  
  /// The app’s bundle is read-only; you can’t add new files to it or modify existing ones.
  static func bundle(pathWith name: String) throws -> URL {
    guard let url = Bundle.main.url(forResource: name, withExtension: nil) else {
      throw AYFileManagerPathError.notFound
    }
    return url
  }
  
  static func documents() throws -> URL {
    return try FileManager.default
      .url(for: .documentDirectory,
           in: .userDomainMask,
           appropriateFor: nil,
           create: false)
  }
}
