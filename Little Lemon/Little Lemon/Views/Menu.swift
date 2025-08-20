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
    @State var startersOn = false
    @State var mainsOn = false
    @State var dessertOn = false
    @State var drinksOn = false
    @State var menuFetched = false
    
    var body: some View {
        NavigationView{
            VStack{
               
                VStack{
                    HeroContent()
                    TextField("Search menu for...", text: $searchText)
                        .textFieldStyle(.roundedBorder)
                        .padding(.top,-15)
                    
                }.frame(maxWidth: .infinity, alignment:.leading)
                 .padding(.trailing,8)
                 .padding(.leading,8)
                 .padding(.bottom,15)
                 .background(Color(#colorLiteral(red: 0.286, green: 0.369, blue: 0.341, alpha: 1)))
                 
                VStack{
                    Text("ORDER FOR DELIVERY")
                        .frame(maxWidth:.infinity,alignment:.leading)
                        .font(Font.custom("Karla-ExtraBold",size:20))
                        .padding(2)
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing:-3){
                            Toggle(isOn: $startersOn){
                                    Text("Starters")
                                    .padding([.leading, .trailing], 15)
                                    .padding([.top, .bottom], 8)
                                    .background(startersOn ? Color(#colorLiteral(red: 0.933, green: 0.6, blue: 0.447, alpha: 1)) : Color(#colorLiteral(red: 0.929, green: 0.937, blue: 0.933, alpha: 1)))
                                    .cornerRadius(20)
                                    
                            }
                                .toggleStyle(.button)
                                .tint(.clear)
                                .font(Font.custom("Karla-Bold",size:18))
                                .foregroundColor(.black)
                                
                            Toggle(isOn: $mainsOn){
                                    Text("Mains")
                                    .padding([.leading, .trailing], 15)
                                    .padding([.top, .bottom], 8)
                                    .background(mainsOn ? Color(#colorLiteral(red: 0.933, green: 0.6, blue: 0.447, alpha: 1)) : Color(#colorLiteral(red: 0.929, green: 0.937, blue: 0.933, alpha: 1)))
                                    .cornerRadius(20)
                                    
                            }
                                .toggleStyle(.button)
                                .tint(.clear)
                                .font(Font.custom("Karla-Bold",size:18))
                                .foregroundColor(.black)
                            
                            Toggle(isOn: $dessertOn){
                                    Text("Dessert")
                                    .padding([.leading, .trailing], 15)
                                    .padding([.top, .bottom], 8)
                                    .background(dessertOn ? Color(#colorLiteral(red: 0.933, green: 0.6, blue: 0.447, alpha: 1)) : Color(#colorLiteral(red: 0.929, green: 0.937, blue: 0.933, alpha: 1)))
                                    .cornerRadius(20)
                                    
                            }
                                .toggleStyle(.button)
                                .tint(.clear)
                                .font(Font.custom("Karla-Bold",size:18))
                                .foregroundColor(.black)
                            
                            Toggle(isOn: $drinksOn){
                                    Text("Drinks")
                                    .padding([.leading, .trailing], 15)
                                    .padding([.top, .bottom], 8)
                                    .background(drinksOn ? Color(#colorLiteral(red: 0.933, green: 0.6, blue: 0.447, alpha: 1)) : Color(#colorLiteral(red: 0.929, green: 0.937, blue: 0.933, alpha: 1)))
                                    .cornerRadius(20)
                                    
                            }
                                .toggleStyle(.button)
                                .tint(.clear)
                                .font(Font.custom("Karla-Bold",size:18))
                                .foregroundColor(.black)
                        }
                    }
                }.padding(.leading,10)
                    
                
              
                FetchedObjects(predicate:buildPredicate(), sortDescriptors: buildSortDescriptors()) { (dishes: [Dish]) in
                    NavigationStack{
                        
                        List{
                            ForEach(dishes) {dish in
                                NavigationLink(destination: DishDetail(dish:dish)){
                                    HStack{
                                        VStack{
                                            Text(dish.title!)
                                                .frame(maxWidth:.infinity,alignment:.leading)
                                                .font(Font.custom("Karla-Bold",size:16))
                                                .frame(alignment:.leading)
                                            Text(dish.desc!)
                                                .frame(maxWidth:.infinity,alignment:.leading)
                                                .font(Font.custom("Karla-Regular",size:14))
                                                .foregroundColor(Color(#colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)))
                                                .lineLimit(2)
                                                .padding(.top,1)
                                                .padding(.bottom,5)
                                            
                                            Text("$\(dish.price!)")
                                                .frame(maxWidth:.infinity,alignment:.leading)
                                                .font(Font.custom("Karla-Regular",size:16))
                                        }.frame(alignment:.leading)
                                        
                                        AsyncImage(url: URL(string: dish.image!)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 100, height: 100)
                                        .cornerRadius(10)
                                    }
                                }
                            }
                        }.frame(maxWidth:.infinity)
                            .contentMargins(.all, 0)
                            .cornerRadius(0)
                    }
                }
            }.onAppear(){
                if !menuFetched {
                    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Dish")
                        if let count = try? viewContext.count(for: fetchRequest){
                            if count > 0 {
                                menuFetched = true
                            }else{
                                getMenuData()
                            }
                        }
                }
            }
        }
    }
    
    func getMenuData() {
        PersistenceController.shared.clear()

        let url = URL(string:"https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let request = URLRequest(url: url)
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
                        addDish.category = item.category
                       // print(oneDish)
                    }
                    try? viewContext.save()
                    menuFetched = true
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
        
        var filterCategory = [String]()
        if startersOn { filterCategory.append("starters") }
        if mainsOn { filterCategory.append("mains") }
        if dessertOn { filterCategory.append("desserts") }
        if drinksOn { filterCategory.append("drinks") }
        
        if filterCategory.count > 0 {
            let searchPhrase = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
            let sortCategory = NSPredicate(format: "category in %@", filterCategory)
            return NSCompoundPredicate(andPredicateWithSubpredicates: [searchPhrase, sortCategory])
        }else{
            return searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
    }
}

#Preview {
    Menu()
}
