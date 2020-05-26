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

import UIKit
import AYRealmer

class ViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // 1. AYRealmer object
    var realmer = AYRealmer(with: AYRConfiguration.user, in: .documents)
    
    // 2. User for saving
    let user = User(email: "tester@gmail.com", fullName: "Tester User")
    
    // 3. Printing users before adding
    let users0: [User] = realmer.objects()
    print(users0)
    
    // 4. Adding
    realmer.add(model: user)
    
    // 5. Printing users after adding
    let users1: [User] = realmer.objects()
    print(users1)
    
    // 6. Removing (by id)
    realmer.remove(id: user.id, type: User.self)
    
    // 7. Printing users after removing
    let users2: [User] = realmer.objects()
    print(users2)
    
  }
}

