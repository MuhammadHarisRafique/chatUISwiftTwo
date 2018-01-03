//
//  ViewController.swift
//  ChatUISwiftTwo
//
//  Created by Higher Visibility on 02/01/2018.
//  Copyright © 2018 Higher Visibility. All rights reserved.
//

import UIKit
import JSQMessagesViewController

struct User{
    
    let id:String
    let name:String
}


class ViewController:JSQMessagesViewController {
    
    
    let userone = User(id: "1", name: "Haris")
    let userTwo = User(id: "2", name: "Rehan")
    
    var currentUser:User{
        
        return userone
        
    }
    var messages = [JSQMessage]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.senderId = self.currentUser.id
        self.senderDisplayName = self.currentUser.name
        
        
        print(self.senderId)
        print(self.senderDisplayName)
        self.messages = self.getMessages()
    }

    func getMessages()->[JSQMessage]{
        
        
        var messagesArray = [JSQMessage]()
        
        let messageOne = JSQMessage(senderId: "1", displayName: "Haris", text: "hi rehan how are U?")
        let messageTwo = JSQMessage(senderId: "2", displayName: "Rehan", text: "I am Fine And U?")
        
        messagesArray.append(messageOne!)
        messagesArray.append(messageTwo!)
        
        return messagesArray
        
    }

    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.messages.count

        
    }
    

    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
         return self.messages[indexPath.row]
    }
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let bubbleFactory = JSQMessagesBubbleImageFactory()
       
        let message = self.messages[indexPath.row]
        
        if  message.senderId == self.currentUser.id{
        
         return bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.blackColor())
        
        
        }else{
        
        return bubbleFactory.incomingMessagesBubbleImageWithColor(UIColor.redColor())
        }
     
    }
    
    private func receivingmessage(){
    
         let message = JSQMessage(senderId: "2", displayName: "Rehan", text: "great")
        
        self.messages.append(message)
        finishReceivingMessage()
        
    
    }
    

    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        let message = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        self.messages.append(message)
       
        finishSendingMessage()
         self.receivingmessage()
        
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }

    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
    
        let message = self.messages[indexPath.row]
        let user = message.senderDisplayName
        return NSAttributedString(string: user)
        
        
    }
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return 15
    }
    
}

