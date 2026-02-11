---
name: ios-xcode-2026
description: iOS 26 and Xcode 26 development workflow. Use when building iOS apps with Liquid Glass design, Foundation Models (on-device AI), App Intents, or Xcode 26 Coding Tools. Covers Swift, SwiftUI, Apple Intelligence integration, and 2026 platform features.
---

# iOS & Xcode 2026 Development

Guidance for iOS 26 and Xcode 26 development, including Liquid Glass design, Foundation Models, App Intents, and Xcode tooling.

## Quick Reference

| Topic | Resources |
|-------|-----------|
| Liquid Glass | [Adopting Liquid Glass](https://developer.apple.com/documentation/technologyoverviews/adopting-liquid-glass), [HIG](https://developer.apple.com/design/human-interface-guidelines/) |
| Foundation Models | [Foundation Models](https://developer.apple.com/documentation/foundationmodels), [Code-along](https://developer.apple.com/videos/play/wwdc2025/259/) |
| Xcode 26 | [What's new in Xcode 26](https://developer.apple.com/videos/play/wwdc2025/247/) |
| App Intents | [App Intents updates](https://developer.apple.com/documentation/updates/appintents) |
| Cursor + iOS | Sweetpad for build/run; Inject/HotSwiftUI for hot reload |

## Swift 6 & Modern Patterns

- **Swift 6**: Strict concurrency checking; avoid `Task` as type name
- **Observation framework**: Prefer `@Observable` + `@Bindable` over `ObservableObject` for new code (iOS 17+)
- **Navigation**: `NavigationStack` / `NavigationSplitView`; avoid `NavigationView`
- **Cursor workflow**: Use Sweetpad extension + Inject for Cursor-based iOS development with hot reload

## Foundation Models (On-Device AI)

Use the Foundation Models framework for:
- Text extraction, summarization, classification
- Content generation, semantic search
- Assistants, Writing Tools, Genmoji, Image Playground

Key points:
- **On-device**: private, offline, no per-request cost
- Requires Xcode 26 beta, macOS Tahoe, Apple silicon for development
- Follow [HIG for Generative AI](https://developer.apple.com/design/human-interface-guidelines/generative-ai)

## Liquid Glass Design

- New dynamic material across Apple platforms
- Update app icons with Icon Composer (multi-layer, dynamic previews)
- Adopt Liquid Glass for new UI elements per HIG

## App Intents

- Deep integration with Siri, Spotlight, widgets, Shortcuts, Control Center
- Visual search logic for app-specific deep links
- Context-aware Action Button, interactive Widgets

## Xcode 26 Workflow

1. **Coding Tools**: LLM-assisted inline edits, docs, fixes (Apple silicon + macOS Tahoe)
2. **Swift Build**: Open-source build engine, faster incremental builds
3. **Instruments**: ProcessorTrace, CPUCounter, SwiftUI instrument
4. **Testing**: Record/replay XCUIAutomation, test plans across locales/devices

## When to Use This Skill

- Building iOS apps targeting iOS 26
- Integrating on-device AI (Foundation Models)
- Adopting Liquid Glass design
- Using Xcode 26 Coding Tools or Swift Build
- Setting up Cursor + Sweetpad + Inject for iOS development
- Adding App Intents, Declared Age Range, or Games app features

## Additional Resources

- Rules: `@ios-app`, `@xcode-ios`
- iOS 26 release notes: [developer.apple.com](https://developer.apple.com/documentation/ios-ipados-release-notes)
- Sample code: [developer.apple.com/documentation/samplecode](https://developer.apple.com/documentation/samplecode/)
