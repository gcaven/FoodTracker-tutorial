//
//  RatingControl.swift
//  FoodTracker Tutorial
//
//  Created by Geoffrey Caven on 2017-02-24.
//  Copyright © 2017 Geoffrey Caven. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
  
  //MARK: Properties
  private var ratingButtons = [UIButton]()
  @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
    didSet {
      setupButtons()
    }
  }
  @IBInspectable var starCount: Int = 5 {
    didSet {
      setupButtons()
    }
  }
  
  var rating = 0 {
    didSet {
      updateButtonSelectionStates()
    }
  }

  //MARK: Initialization
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupButtons()
  }
  
  required init(coder: NSCoder) {
    super.init(coder: coder)
    setupButtons()
  }
  
  //MARK: Private Methods
  private func setupButtons() {
    
    // Load Images
    let bundle = Bundle(for: type(of: self))
    let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
    let emptyStar = UIImage(named:"emptyStar", in: bundle, compatibleWith: self.traitCollection)
    let highlightedStar = UIImage(named:"highlightedStar", in: bundle, compatibleWith: self.traitCollection)
    
    // Remove existing buttons
    for button in ratingButtons {
      removeArrangedSubview(button)
      button.removeFromSuperview()
    }
    ratingButtons.removeAll()
    
    // Create new buttons
    for index in 0..<starCount {
      let button = UIButton()
      
      // Set images
      button.setImage(emptyStar, for: .normal)
      button.setImage(filledStar, for: .selected)
      button.setImage(highlightedStar, for: .highlighted)
      button.setImage(highlightedStar, for: [.highlighted, .selected])
      
      // Add autolayout contstraints
      button.translatesAutoresizingMaskIntoConstraints = false
      button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
      button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
      
      // Set the accessibility label
      button.accessibilityLabel = "Set \(index + 1) star rating"
      
      // Attach to touch event
      button.addTarget(self, action: #selector(RatingControl.ratingButtonTapped(button:)), for: .touchUpInside)
      
      // Add to view and array
      addArrangedSubview(button)
      ratingButtons.append(button)
    }
    updateButtonSelectionStates()
  }
  
  //MARK: Button Action
  func ratingButtonTapped(button: UIButton) {
    guard let index = ratingButtons.index(of: button) else {
      fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
    }
    
    let selectedRating = index + 1
    if selectedRating == rating {
      rating = 0
    } else {
      rating = selectedRating
    }
  }
  
  private func updateButtonSelectionStates() {
    for (index,button) in ratingButtons.enumerated() {
      
      // Set all buttons below rating to selected state
      button.isSelected = index < rating
      
      // Set the hint string for the currently selected star
      let hintString: String?
      if rating == index + 1 {
        hintString = "Tap to reset the rating to zero."
      } else {
        hintString = nil
      }
      
      // Calculate the value string
      let valueString: String
      switch (rating) {
      case 0:
        valueString = "No rating set."
      case 1:
        valueString = "1 star set."
      default:
        valueString = "\(rating) stars set."
      }
      
      // Assign the hint string and value string
      button.accessibilityHint = hintString
      button.accessibilityValue = valueString
    }
  }
}
