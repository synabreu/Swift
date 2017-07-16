//
//  File Name    : ViewController.swift
//  Project Name : MySiri
//  Overview     : This prototype shows you to transform your voice into text both English and Korean language using speechFramework. So This app was compiled by XCode 9 Beta 3 and Swift 4.
//
//  Created by Jinho Seo on 7/12/17.
//  Copyright © 2017 Jinho Seo. All rights reserved.
//

import UIKit
import Speech

// 1. adopt the SFSpeechRecognizerDelegate protocol. This procol is only for 10.3 higher version
class ViewController: UIViewController, SFSpeechRecognizerDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var microphoneButton: UIButton!
    
    @IBOutlet weak var languageSwitch: UISwitch!
    
    // ********** local Variables ******************
    // 2. The user must allow the app to use the input audio and speech recognition because all the voice data is transmitted to Apple's backend for processing. Therefore, it is mandatory to get the user's authorization.
    // Create an SFSpeechRecognizer instance with a locale identifier of en-US so the speech recognizer knows what language the user is speaking in. This is the object that handles speech recognition.
    // private let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
    private var speechRecognizer: SFSpeechRecognizer?
    
    // This object handle the speech recognition requests. It provides an audio input to the speech recognizer.
    private var recognitionRequest : SFSpeechAudioBufferRecognitionRequest?
    
    // The recognition task where it gives you the result of the recognition request. Having this object is handy as you can cancel or stop the risk.
    private var recognitionTask : SFSpeechRecognitionTask?
    
    // Create my audio engine for providing my audio input
    private let audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize user controls -- not important.
        initControls()
        
        // 3. Disable the microphone button until the speech recognizer is activated.
        microphoneButton.isEnabled = false
        
        // 4. Set the speech recognizer delegate to self which in this case is our ViewController.
        speechRecognizer?.delegate = self
        
        // 5. Request the authorization of Speech Recognization by calling SFSpeechRecognizer.requestAuthorization.
        SFSpeechRecognizer.requestAuthorization {(authStatus) in
        
            var isButtonEnabled = false
            
            // 6. Check the status of the verification. If it's authorized, enable the microphone button. if not, print the error message and disable the microphone button.
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
            case .restricted:
                isButtonEnabled = false
            case .notDetermined:
                print("Speech recognition not yet authorized")
            }
            
            // *** 7. Apple requires all the authorization to have a custom message from the app. In case of speech authorization, you must authorize two things. - Microphone usage and Speech Recognition. To customize the messages, you must supply these custom messages through the info.plist file.
            OperationQueue.main.addOperation() {
                self.microphoneButton.isEnabled = isButtonEnabled
            }
            
        }
        
    }
    

    // Check whether our audioENgine is running.
    @IBAction func microphoneTapped(_ sender: Any) {
        
        // if it is running, the app should stop the audioEngine, terminate the input audio to our recognitionRequest, disable our microphoneButton, and set the button's title to "Start Recording". 
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            microphoneButton.isEnabled = false
            
            if languageSwitch.isOn {
                microphoneButton.setTitle("Start Recording", for: .normal)
            } else {
                microphoneButton.setTitle("녹음 시작", for: .normal)
            }
        } else { // if the audioEngine is working, the app should call startRecording() and set the title of the button to "Stop Recording".
            startRecording()
            
            if languageSwitch.isOn {
                microphoneButton.setTitle("Stop Recording", for: .normal)
            } else {
                microphoneButton.setTitle("녹음 끝", for: .normal)
            }
        }
    }

    // Implement the availabilityDidChange method of the SFSpeechRecognizerDeletegate proptocol.
    // This method will be called when the avilability changes. If speech recognition is available, the record button will also be enabled.
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        
        // if speech recognition is unavailable or changes its status, the microphoneButton.enable property should be set.
        if available {
            microphoneButton.isEnabled = true
        } else {
            microphoneButton.isEnabled = false
        }
    }

    // 8. Process to record your voice when you click on the "Start Recording" Button.
    func startRecording() {
       
        // Check if recognitionTask is running. If so, cancel the task and the recognition.
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        // Create an AVAudioSession to prepare for the audio recording. Set the category of the session as recording, the mode as measurement, and activate it.
        let audioSession = AVAudioSession.sharedInstance()
        
        // You must put it in a try catch clause because setting these properties may throw an exception.
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        // Instantiate the recognitionRequest by creating the SFSpeechAudioBufferRecognitionRequest object.
        // later, we use it to pass our audio data to Apple's servers.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        // Check if the audioEngine (your device) has an audio input for recording. ** -- If not, we report a fatal error.
        let inputNode = audioEngine.inputNode
/*
        #if swift(>=4.0)
            let inputNode  = audioEngine.inputNode
        #else
            guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
            }
        #endif
*/
        
        // Check if the recognitionRequest object is instatiated and is not nil.
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object.")
        }
        
        // Tell recognitionRequest to report partial results of speech recognition as the user speaks.
        recognitionRequest.shouldReportPartialResults = true
        
        // Start the recognition by calling the recognitionTask method of our speechRecognizer. 
        // This complettion handler will be called every time the recognition engine has received input, has refined its current recognition, or has been canceled or stopped, and will return a final transcript.
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
        
            // Define a boolean to determine if the recognition is final. 
            var isFinal = false
            
            // If the result isn't nil, set the textView.text property as our result's best transcription.
            if result != nil {
                self.textView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)! // if the result is the final result, set isFinal to true.
            }
            
            // if there is no error or the result is final, stop the audioEngine(audio input) and stop the recognitionRequest and recognitionTask.
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                // Enable the start Recording button.
                self.microphoneButton.isEnabled = true
            }
        })
        
        // Add an audio input to the recognitionRequest.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        
        // Add the audio input after starting the recognitionTask. The speech Framework will start recognizing as soon as an audio input has been added.
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in self.recognitionRequest?.append(buffer)
        }

        // Prepare and start the audioEngine.
        audioEngine.prepare()
        
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        // Display a text when progressing.
        progressDisplayText()
        
        
    }
    
    // When the user is clicked on the switch button
    @IBAction func languageSwitchTapped(_ sender: Any) {
        initControls()
    }
    
    // When the view is loaded, the user control is initialized and set up the types of languages on the speechRecognizer
    func initControls() {
        if languageSwitch.isOn { // right
            titleLabel.text = "What can I help you with?"
            optionLabel.text = "Language Setting: (English) "
            textView.text = "Result: It is convert from your voice to text!"
            microphoneButton.setTitle("Start Recording", for: .normal)
            
            speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
            
            
        } else {
            titleLabel.text = "내가 무엇을 도와줄까요?"
            optionLabel.text = "언어 설정: (우리말)"
            textView.text = "결과 화면: 음성을 글로 보여줍니다!"
            microphoneButton.setTitle("녹음 시작", for: .normal)
            
            speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ko-KR"))
            
        }
    }
    
    // when the user is recording on the voice, display a text for helping it.
    func progressDisplayText() {
        if languageSwitch.isOn {
            textView.text = "Say something, I'm listening!"
            
        } else {
            textView.text = "아무거나 말하세요! 전 듣고 있어요!"
            
        }

    }
    

}

