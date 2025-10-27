# API Explorer (Rick and Morty)

A SwiftUI (iOS 17+) application that fetches real data from the Rick and Morty API.  
It features search, pagination, detail and favorites screens, pull-to-refresh, and basic image caching.

## Requirements
- iOS **17.0+**
- Xcode 15+
- Swift 5.9+

## Technologies Used
- **SwiftUI** (`NavigationStack`, `LazyVGrid`, `.refreshable`, `AsyncImage`)
- **Swift Concurrency**: `async/await`
- **Networking**: `URLSession`
- **JSON → Codable`
- **Architecture**: Clean MVVM (View / ViewModel / Service / Models)
- **Image Caching**: `NSCache`
- **Persistence**: `UserDefaults` for favorites
- **Testing**: Unit Tests + UI Tests (`XCTest`, `XCUIApplication`)
 
## API
- Rick and Morty API — https://rickandmortyapi.com/documentation
- List endpoint: `/api/character?page={n}&name={query}`
- Detail endpoint: `/api/character/{id}`

## Features
- Network calls with `async/await` and `URLSession`
- Scrollable grid list and detailed character screen
- Search by name (server-side `name=` query)
- Infinite scrolling / pagination
- Pull-to-refresh support
- Image loading via `AsyncImage`
- Error and empty state handling
- Favorites list with local persistence
- Unit & UI Tests

## Tests
- **Unit Tests** (`APIExplorerTests`)
  - `CharacterServiceTests`: JSON decoding and network response validation
  - `CharacterListViewModelTests`: state handling (idle → loading → loaded)
- **UI Tests** (`APIExplorerUITests`)
  - `testSearchAndOpenDetail`: performs search and navigates to the detail screen
