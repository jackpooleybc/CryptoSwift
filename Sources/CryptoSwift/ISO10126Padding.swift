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

import Foundation

struct ISO10126Padding: PaddingProtocol {
    
    func add(to bytes: Array<UInt8>, blockSize: Int) -> Array<UInt8> {
        let padding = UInt8(blockSize - (bytes.count % blockSize))
        var withPadding = bytes
        withPadding += iso10126PaddingBytes(for: padding)
        return withPadding
    }

    func remove(from bytes: Array<UInt8>, blockSize _: Int?) -> Array<UInt8> {

        guard !bytes.isEmpty, let lastByte = bytes.last else {
            return bytes
        }

        assert(!bytes.isEmpty, "Need bytes to remove padding")

        let padding = Int(lastByte) // last byte
        let finalLength = bytes.count - padding

        if finalLength < 0 {
            return bytes
        }
        
        if padding >= 1 {
            return Array(bytes[0..<finalLength])
        }
        
        return bytes
    }
    
    private func iso10126PaddingBytes(for padding: UInt8) -> Array<UInt8> {
        var bytes = Array<UInt8>()
        guard padding > 0 else {
            return bytes
        }
        for _ in 0..<(padding-1) {
            let pad = UInt8(arc4random() % 254 + 1)
            bytes.append(pad)
        }
        return bytes + [padding]
    }
}
