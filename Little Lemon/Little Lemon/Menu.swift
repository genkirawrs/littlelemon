//
//  Menu.swift
//  Little Lemon
//
//  Created by Roz on 8/10/25.
//

import SwiftUI
import CoreData

struct Menu: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State var searchText = ""
    
    var body: some View {
        VStack{
           Image("little-lemon-logo")
                
           VStack{
                Text ("Little Lemon")
                Text ("Chicago")
                Text ("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                
           }.background(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)))

           TextField("Search menu", text: $searchText)
           FetchedObjects(predicate:buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
               NavigationStack{
                   List{
                       ForEach(dishes) {dish in
                               HStack{
                                       Text(dish.title!)
                                       //Text(dish.description!)
                                       Text("$ \(dish.price!)")
                                       AsyncImage(url: URL(string: dish.image!)) { image in
                                           image.resizable()
                                       } placeholder: {
                                           ProgressView()
                                       }
                                       .frame(width: 50, height: 50)
                               }
                       }
                   }
                   
                   
               }
            }
        }.onAppear(){
            getMenuData(viewContext:viewContext)
        }
    }
    
    func getMenuData(viewContext: NSManagedObjectContext) {
        PersistenceController.shared.clear()

        let url = URL(string:"https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")
        let request = URLRequest(url: url!)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let importedMenu = try? decoder.decode(MenuList.self, from: data){
                    let finalMenu = importedMenu.menu
                    for item in finalMenu {
                        let addDish = Dish(context:viewContext)
                        addDish.title = item.title
                        addDish.price = item.price
                        addDish.desc = item.description
                        addDish.image = item.image
                       // print(oneDish)
                    }
                    try? viewContext.save()
                }
            }
        }
        task.resume()
    }
    
    func buildSortDescriptors () -> [NSSortDescriptor] {
        return [
            NSSortDescriptor(key: "title", ascending: true, selector: #selector(NSString.localizedStandardCompare))
        ]
    }
    
    func buildPredicate() -> NSPredicate{
        return searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
    }
}

#Preview {
    Menu()
}
