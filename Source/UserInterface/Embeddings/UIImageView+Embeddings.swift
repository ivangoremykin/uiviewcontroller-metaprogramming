//
//  UIImageView+Embeddings.swift
//  UIViewControllerMetaprogramming
//
//  Created by Ivan Goremykin on 14/08/2019.
//  Copyright © 2019 Ivan Goremykin. All rights reserved.
//

import UIKit

extension UIView
{
    func embedSeasonImageView(_ image: UIImage)
    {
        let imageView = UIImageView(image: image)
        
        // Add to scene
        addSubview(imageView)
        
        // Content Mode
        imageView.contentMode = .scaleAspectFit
        
        // Size
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33).isActive = true
        imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1).isActive = true
        
        // Position
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
}
