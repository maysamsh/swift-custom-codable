import SwiftUI

struct ContentView: View {
    @State var cityName: String = "Loading..."
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(cityName)
        }
        .onAppear {
            loadData()
        }
    }
    
    func loadData() {
        guard let fileURL = Bundle.main.url(forResource: "sample", withExtension: "json") else {
            return
        }
        
        guard let content = try? Data(contentsOf: fileURL) else {
            return
        }
        
        let sampleContent = try? JSONDecoder().decode(SamplePayload.self, from: content)
        self.cityName = sampleContent?.billTo?.city ?? "Failed to load city"
    }
}
