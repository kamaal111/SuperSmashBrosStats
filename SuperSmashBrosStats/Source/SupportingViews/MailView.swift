//
//  MailView.swift
//  SuperSmashBrosStats
//
//  Created by Kamaal Farah on 22/06/2020.
//  Copyright © 2020 Kamaal. All rights reserved.
//

import SwiftUI
import KamaalUI
import MessageUI

struct MailView: View {
    @Binding var showFeedbackSheet: Bool
    @Binding var mailResult: Result<MFMailComposeResult, Error>?

    let canSendMail = MFMailComposeViewController.canSendMail()

    var body: some View {
        ZStack {
            if self.canSendMail {
                KMailView(
                    isShowing: self.$showFeedbackSheet,
                    result: self.$mailResult,
                    emailAddress: "app.kamaal@gmail.com",
                    emailSubject: "Send Feedback Super Smash Stats")
            } else {
                NoMailView()
            }
        }
    }
}

struct NoMailView: View {
    @State private var spinEmojiDegrees: Double = 0

    var body: some View {
        VStack(alignment: .leading) {
            Text("Oops, Could not set up the email window")
                .font(.title)
            Text("To be able to send emails you need to install/configure Apples Mail app")
                .font(.caption)
                .padding(.vertical, 16)
            Text("😁")
                .font(.system(size: CGFloat(UIScreen.main.bounds.width / 2)))
                .frame(maxWidth: .infinity, alignment: .center)
                .rotationEffect(.degrees(self.spinEmojiDegrees))
            Text("Please don't give up kind person")
                .font(.footnote)
                .padding(.vertical, 16)
        }
        .padding(.top, 40)
        .padding(.horizontal, 40)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .onAppear(perform: self.onNoMailAppear)
    }

    func onNoMailAppear() {
        withAnimation(.easeIn(duration: 1)) {
            self.spinEmojiDegrees += 360
        }
    }
}

//struct MailView_Previews: PreviewProvider {
//    static var previews: some View {
//        MailView()
//    }
//}
