//
//  RecipeDescriptionVC.swift
//  SweetLayers
//
//  Created by 1 on 17/01/25.
//

import UIKit

class RecipeDescriptionVC: UIViewController {
    
    @IBOutlet weak var cakeImageView: UIImageView!
    @IBOutlet weak var recipeLabel: UILabel!
    let descriptions: [String] = [
    """
• Ingredients: 300g strawberries, 200ml cream, 50g sugar, 100g dark chocolate, pink petals for decoration.
• Recipe: Melt the dark chocolate. Puree the strawberries and mix with sugar. Whip the cream and gently mix with the strawberry mixture and melted chocolate. Pour into glasses and decorate with pink petals. Chill in the refrigerator.
""", """
• Ingredients: 300g strawberries, 200ml cream, 50g sugar, 100g dark chocolate, pink petals for decoration.
• Recipe: Melt the dark chocolate. Puree the strawberries and mix with sugar. Whip the cream and gently mix with the strawberry mixture and melted chocolate. Pour into glasses and decorate with pink petals. Chill in the refrigerator.
""", """
• Ingredients: 200g blueberries, 200ml cream, 100g sugar, 1 tbsp gelatin, 100g dark chocolate.
• Recipe: Melt the dark chocolate. Dissolve the gelatin in a small amount of water. Whip the cream with sugar and add the gelatin. Puree the blueberries and add to the cream mixture along with the melted chocolate. Mix well and chill in the refrigerator.
""", """
• Ingredients: 300g blueberries, 200ml cream, 50g sugar, 100g dark chocolate, blue petals for decoration.
• Recipe: Melt the dark chocolate. Puree the blueberries and mix with sugar. Whip the cream and gently mix with the blueberry mixture and melted chocolate. Pour into glasses and decorate with blue petals. Chill in the refrigerator.
""", """
• Ingredients: 200g strawberries, 200ml cream, 100g sugar, 100g dark chocolate.
• Recipe: Melt the dark chocolate. Whip the cream with sugar. Puree the strawberries and add to the cream mixture along with the melted chocolate. Mix well and pour into glasses. Chill in the refrigerator.
""", """
• Ingredients: 300g blueberries, 200ml cream, 50g sugar, 100g dark chocolate, blue petals for decoration.
• Recipe: Melt the dark chocolate. Puree the blueberries and mix with sugar. Whip the cream and gently mix with the blueberry mixture and melted chocolate. Pour into glasses and decorate with blue petals. Chill in the refrigerator.
""", """
• Ingredients: 200g blackberries, 200ml cream, 100g sugar, 100g dark chocolate.
• Recipe: Melt the dark chocolate. Whip the cream with sugar. Puree the blackberries and add to the cream mixture along with the melted chocolate. Mix well and pour into glasses. Chill in the refrigerator.
""", """
• Ingredients: 200g Cherries, 200ml cream, 200g cream cheese, 100g sugar, 100g dark chocolate.
• Recipe: Melt the dark chocolate. Mix cream cheese with sugar. Whip the cream and add to the cheese mixture. Puree the strawberries and add to the mixture along with the melted chocolate. Mix well and pour into a pan. Chill in the refrigerator.
""", """
• Ingredients: 200ml heavy cream, 100g granulated sugar, 1 tbsp gelatin, 100g dark chocolate, 2 tbsp water, 1 tsp vanilla extract.
• Recipe: Melt the dark chocolate. Dissolve the gelatin in water and let it bloom. Whip the cream with sugar and vanilla. Heat the gelatin until liquid and add to the cream. Mix in the melted chocolate. Pour into glasses and chill.
""", """
• Ingredients: 200ml heavy cream, 50g granulated sugar, 100g dark chocolate, 1 tsp vanilla extract.
• Recipe: Melt the dark chocolate. Whip the cream with vanilla. Fold in the melted chocolate. Pour into glasses and chill.
""", """
• Ingredients: 200g strawberries, 200ml cream, 100g sugar, 2 eggs, 100g dark chocolate.
• Recipe: Melt the dark chocolate. Whip the eggs with sugar. Add the cream and pureed strawberries. Mix in the melted chocolate. Pour into ramekins and bake at 180°C for 20 minutes.
""", """
• Ingredients: 200g strawberries, 200ml cream, 100g sugar, 100g dark chocolate.
• Recipe: Melt the dark chocolate. Whip the cream with sugar. Puree the strawberries and add to the cream mixture along with the melted chocolate. Mix well and pour into glasses. Chill in the refrigerator.
"""
    ]
    var index: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        if let index = index {
            recipeLabel.text = descriptions[index]
            cakeImageView.image = UIImage(named: "recipe\(index)")
        }
    }
    @IBAction func xTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
