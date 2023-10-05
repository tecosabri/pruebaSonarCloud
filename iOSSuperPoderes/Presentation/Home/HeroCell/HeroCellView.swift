//
//  HeroCellView.swift
//  iOSSuperPoderes
//
//  Created by Ismael Sabri Pérez on 24/7/23.
//

import SwiftUI

struct HeroCellView: View {
    
    var hero: Hero
    
    init(hero: Hero) {
        self.hero = hero
    }
    
    var body: some View {
        VStack(alignment: .leading, content: { // Para alinear al inicio
            HStack(content: { // Para el row
                // Imagen
                AsyncImage(url: URL(string: hero.photo),
                           content: { image in
                               image.resizable()
                        .aspectRatio(contentMode: .fill)
                                    .frame(width: 130, height: 73)
                           },
                           placeholder: {
                               ProgressView()
                           })
                
                // Nombre y descripción alineados al principio
                VStack (alignment: .leading, content: {
                    Text(hero.name)
                        .fontWeight(.semibold)
                        //.font(.title3)
                        .font(.system(size: 14))
                    Text(hero.description)
                        .font(.system(size: 12))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(3)
                })
                
                
                Spacer() // Spacer para apretar todo a la izquierda
            })
        })
        
    }
}

//struct HeroCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        HeroCellView(hero:)
//            .previewLayout(.fixed(width: /*@START_MENU_TOKEN@*/390.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/73.0/*@END_MENU_TOKEN@*/))
//    }
//}
