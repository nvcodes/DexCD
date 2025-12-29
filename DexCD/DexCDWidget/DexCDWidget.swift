//
//  DexCDWidget.swift
//  DexCDWidget
//
//  Created by Nagaraju on 29/12/25.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry.placeholder
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry.placeholder
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry.placeholder
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let name: String
    let types: [String]
    let sprite: Image
    
    static var placeholder: SimpleEntry {
        SimpleEntry(
            date: .now,
            name: "bulbasaur",
            types: ["gross", "poison"],
            sprite: Image(.bulbasaur)
        )
    }
    
    static var placeholder2: SimpleEntry {
        SimpleEntry(
            date: .now,
            name: "mew",
            types: ["psychic"],
            sprite: Image(.mew)
        )
    }

}

struct DexCDWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            entry.sprite
        }
    }
}

struct DexCDWidget: Widget {
    let kind: String = "DexCDWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                DexCDWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                DexCDWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    DexCDWidget()
} timeline: {
    SimpleEntry.placeholder
    SimpleEntry.placeholder2
}
