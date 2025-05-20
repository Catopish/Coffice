//
//  cofficewidgetLiveActivity.swift
//  cofficewidget
//
//  Created by Angel on 17/05/25.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct cofficewidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct cofficewidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: cofficewidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension cofficewidgetAttributes {
    fileprivate static var preview: cofficewidgetAttributes {
        cofficewidgetAttributes(name: "World")
    }
}

extension cofficewidgetAttributes.ContentState {
    fileprivate static var smiley: cofficewidgetAttributes.ContentState {
        cofficewidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: cofficewidgetAttributes.ContentState {
         cofficewidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: cofficewidgetAttributes.preview) {
   cofficewidgetLiveActivity()
} contentStates: {
    cofficewidgetAttributes.ContentState.smiley
    cofficewidgetAttributes.ContentState.starEyes
}
