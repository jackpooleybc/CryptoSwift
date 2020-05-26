////  CryptoSwift
//
//  Copyright (C) 2014-__YEAR__ Marcin Krzyżanowski <marcin@krzyzanowskim.com>
//  This software is provided 'as-is', without any express or implied warranty.
//
//  In no event will the authors be held liable for any damages arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose,including commercial applications, and to alter it and redistribute it freely, subject to the following restrictions:
//
//  - The origin of this software must not be misrepresented; you must not claim that you wrote the original software. If you use this software in a product, an acknowledgment in the product documentation is required.
//  - Altered source versions must be plainly marked as such, and must not be misrepresented as being the original software.
//  - This notice may not be removed or altered from any source or binary distribution.
//

import XCTest
@testable import CryptoSwift

// SOURCE: https://github.com/kayon/crypt/blob/master/padding_test.go
class ISO10126PaddingTests: XCTestCase {
    
    let blockSize: Int = 8

    func testPadding1() throws {
        let bytes: Array<UInt8> = [1, 2, 3, 4, 5]
        let paddedBytes = ISO10126Padding().add(to: bytes, blockSize: blockSize)
        XCTAssertEqual(paddedBytes[7], 3)
    }
    
    func testPadding2() throws {
        let bytes: Array<UInt8> = [1, 2, 3, 4, 5, 6, 7, 8]
        let paddedBytes = ISO10126Padding().add(to: bytes, blockSize: blockSize)
        XCTAssertEqual(paddedBytes[15], 8)
    }
    
    func testUnpadding() throws {
        let bytes: Array<UInt8> = [1, 2, 3, 4, 5, 6, 7, 8]
        let paddedBytes = ISO10126Padding().add(to: bytes, blockSize: blockSize)
        let unpaddedBytes = ISO10126Padding().remove(from: paddedBytes, blockSize: blockSize)
        XCTAssertEqual(unpaddedBytes, bytes)
    }
}
