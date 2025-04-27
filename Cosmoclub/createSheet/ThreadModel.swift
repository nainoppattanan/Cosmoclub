//
//  ThreadModel.swift
//  Cosmoclub
//
//  Created by Pattanan Naosaran on 27/4/2568 BE.
//

import Foundation
import PhotosUI

struct Thread: Identifiable {
    var id = UUID()
    var content: String
    var image: UIImage?
}
