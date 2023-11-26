//
//  ProductView.swift
//  Inventory
//
//  Created by Sean Grady on 11/24/23.
//

import SwiftUI
import CoreData

struct ProductView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var groupName : String
    
    init (groupName : String = "")
    {
        self.groupName = groupName
    }
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.timestamp, ascending: true)],
        //predicate: NSPredicate(format: "name == %@", groupName),
        animation: .default)
    private var products: FetchedResults<Product>
    
    var body: some View {
        List {
            ForEach(products) { item in
                NavigationLink {
                    //here we pass the group name tp the product view
                    //so it can fetch any existing products
                    Image("boddl")
                    Text("quantity: " + "1")
                    Text("price: " + "100")
                    //item.image.jpegData(self: <#T##UIImage#>, compressionQuality: <#T##CGFloat#>)
                } label: {
                    //Text("static text 2")
                    
                    
                   Text(self.groupName + " - New Item")
                   // if (item.name == self.groupName)
                   // {
                   // }
                    
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Product(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
