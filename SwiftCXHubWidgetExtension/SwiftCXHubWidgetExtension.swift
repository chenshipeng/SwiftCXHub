//
//  SwiftCXHubWidgetExtension.swift
//  SwiftCXHubWidgetExtension
//
//  Created by chenshipeng on 2020/9/7.
//

import WidgetKit
import SwiftUI
import Intents
import Foundation
func getPersistData() -> UserStoreModel?{
    let decoder = JSONDecoder()
    if let filePath =  FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.csp.SwiftCXhub.com")?.path
    {
        var url = URL(fileURLWithPath: filePath)
        url.appendPathComponent("/Library/UserData", isDirectory: false)
        do {
            
            if let data = try? Data(contentsOf: url){
                return try decoder.decode(UserStoreModel.self, from: data)
            }
        } catch let error {
            print("Error while loading: \(error.localizedDescription)")
        }
    }
    
    return nil
}
struct Provider: TimelineProvider {
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> Void) {
        completion(SimpleEntry(date: Date(),trending:[Trending.staticTrending()]))
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(),trending:[Trending.staticTrending()])
    }
//    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date(),trending:[Trending.staticTrending()])
//        completion(entry)
//    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        let currentDate = Date()
        if let data = getPersistData(),let trendings = data.trendings?.first?.value,trendings.count > 0{
            print("trendings \(trendings)")
            var tres = trendings
            for i in 1 ... trendings.count/3 {
                print("start trendings \(tres.count)")
                let slicedTrendins = tres.prefix(3)
                let entryDate = Calendar.current.date(byAdding: .minute, value: i, to: currentDate)!
                let entry = SimpleEntry(date: entryDate,trending:Array(slicedTrendins))
                entries.append(entry)
                tres = Array(tres.dropFirst(3))
                print("end trendings \(tres.count)")
            }
            let timeline = Timeline(entries: entries, policy: .atEnd)
            completion(timeline)
            return
        }
        
        
        for hourOffset in 0 ..< 24 {
            let entryDate = Calendar.current.date(byAdding: .minute, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate,trending:[Trending.staticTrending()])
            
            entries.append(entry)
        }
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
        
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
//    let configuration: ConfigurationIntent
    let trending:[Trending]
}
struct SwiftCXHubWidgetExtensionEntryView : View {
    var entry:Provider.Entry
    @Environment(\.widgetFamily) var family
    var body: some View {
        switch  family{
        case .systemSmall:
            SmallWidget(trending: entry.trending[0])
                .widgetURL(URL(string: entry.trending[0].url!)!)
        case .systemMedium:
            MediumWidget(trending: entry.trending[0])
                .widgetURL(URL(string: entry.trending[0].url!)!)
        default:
            LargeWidget(trendings: entry.trending)
                .widgetURL(URL(string: entry.trending[0].url!)!)
        }
        
    }
}

@main
struct SwiftCXHubWidgetExtension: Widget {
    let kind: String = "SwiftCXHubWidgetExtension"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), content: {entry in
            SwiftCXHubWidgetExtensionEntryView(entry: entry)
        })
        .configurationDisplayName("SwiftCXHub Widget")
        .description("Add SwiftCXHub Widget")
        .supportedFamilies([.systemSmall,.systemMedium,.systemLarge])
    }
}

struct SwiftCXHubWidgetExtension_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            SwiftCXHubWidgetExtensionEntryView(entry: SimpleEntry(date: Date(), trending: [Trending.staticTrending()]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            SwiftCXHubWidgetExtensionEntryView(entry: SimpleEntry(date: Date(), trending: [Trending.staticTrending()]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            SwiftCXHubWidgetExtensionEntryView(entry: SimpleEntry(date: Date(), trending: [Trending.staticTrending(),Trending.staticTrending(),Trending.staticTrending()]))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
extension Color{
    public init?(hexString: String, transparency: CGFloat = 1) {
        var string = ""
        if hexString.lowercased().hasPrefix("0x") {
            string =  hexString.replacingOccurrences(of: "0x", with: "")
        } else if hexString.hasPrefix("#") {
            string = hexString.replacingOccurrences(of: "#", with: "")
        } else {
            string = hexString
        }

        if string.count == 3 { // convert hex to 6 digit format if in short format
            var str = ""
            string.forEach { str.append(String(repeating: String($0), count: 2)) }
            string = str
        }

        guard let hexValue = Int(string, radix: 16) else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }

        let red = (hexValue >> 16) & 0xff
        let green = (hexValue >> 8) & 0xff
        let blue = hexValue & 0xff
        self.init(red: red, green: green, blue: blue, transparency: trans)
    }
    public init?(red: Int, green: Int, blue: Int, transparency: CGFloat = 1) {
        guard red >= 0 && red <= 255 else { return nil }
        guard green >= 0 && green <= 255 else { return nil }
        guard blue >= 0 && blue <= 255 else { return nil }

        var trans = transparency
        if trans < 0 { trans = 0 }
        if trans > 1 { trans = 1 }
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0)
    }
}
