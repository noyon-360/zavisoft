# Daraz-Style Product Listing Architecture

This project implements a complex scroll architecture mimicking a Daraz-style product listing screen.

## Technical Decisions

### 1. How horizontal swipe was implemented
Horizontal navigation between product categories is implemented using standard `TabBarView`. Because the `TabBarView` is placed inside the `body` of a `NestedScrollView`, it handles horizontal drag gestures natively. To ensure these gestures don't conflict with vertical scrolling, we rely on Flutter's internal gesture arena, where the `TabBarView` (or its internal `PageView`) wins horizontal gestures, while the `NestedScrollView` and its inner `CustomScrollView`s handle vertical ones.

### 2. Who owns the vertical scroll and why?
The **`NestedScrollView`** is the primary owner of the vertical scroll coordination. 
- It manages two separate scroll controllers: an **outer** one (for the header, including the banner and search bar) and an **inner** one (for the tab content).
- We use **`SliverOverlapAbsorber`** in the header and **`SliverOverlapInjector`** in each tab's list. This ensures that the inner scroll view is aware of the sticky header's height and scrolls its content under it correctly.
- This approach provides a "Single Scroll" feel where the banner collapses before the product list starts scrolling its own content.

### 3. Trade-offs and Limitations
- **Complexity**: `NestedScrollView` with overlapping slivers is more complex to implement than a single `CustomScrollView`. It requires careful use of `SliverOverlapAbsorber/Injector`.
- **Pull-to-Refresh**: Implementing a global pull-to-refresh that works across all tabs requires careful placement of the `RefreshIndicator`. We've moved it inside each tab to ensure reliable gesture detection.
- **Scroll Synchronization**: While it feels like one scrollable, they are technically two. Extremely rapid scrolling or specific edge cases in sliver calculations can sometimes lead to minor jitter, though this implementation uses standard patterns to minimize it.

### 4. Scalability & Dynamic Categories
- The implementation dynamically fetches **all available categories** from the Fakestore API.
- The `TabBar` is configured with `isScrollable: true`, allowing it to handle any number of categories gracefully.
- Data fetching is optimized to load categories and their respective products in parallel.

## Run Instructions
```bash
flutter run
```
