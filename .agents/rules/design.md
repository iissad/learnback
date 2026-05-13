---
trigger: always_on
---

# LearnBack – Design Tokens & UI Specs
## ✅ Confirmed by design — exact Figma values

---

## 🎨 Color Palette

### Dark Mode
| # | Hex | Token | Usage |
|---|---|---|---|
| 1 | `#0A192F` | `darkBgPrimary` | Main screen background |
| 2 | `#8892B0` | `darkTextSecondary` | Subtitles, helper text |
| 3 | `#00F2FE` | `blueLight` / blueLight | Icons, links, active states, gradient start |
| 4 | `#7367F0` | `colorSixth` / purple | Gradient end, secondary accent |
| 5 | `#4988C4` | `colorThird` | Interactive blue elements |
| 6 | `#1E293B` | `darkBgSecondary` | Cards, input fields, surfaces |
| 7 | `#13A4EC` | `colorForth` | Lighter blue accent |
| 8 | `#729EC9` | `darkBorder` | Borders, muted elements |

### Light Mode
| # | Hex | Token | Usage |
|---|---|---|---|
| 1 | `#D9EAFD` | `lightBgPrimary` | Main screen background |
| 2 | `#0A192F` | `lightTextPrimary` | Primary text |
| 3 | `#112240` | `lightTextSecondary` | Secondary text |
| 4 | `#7367F0` | `lightIcon` | Purple accent, icons |
| 5 | `#00F2FE` | `lightLink` | blueLight accent, links |
| 6 | `#BCCCDC` | `lightBorder` | Borders, dividers |
| 7 | `#9AA6B2` | `lightTextMuted` | Placeholders, disabled |

### Gradient (CTA Buttons)
```
#00F2FE → #7367F0  (blueLight to purple, left to right)
```
Applied to: "Get started", "Next", "Log In", "Resend email"

### Semantic
```
error:   #FF4D6A
success: #00F2FE
warning: #FFB84D
```

---

## 🔤 Typography

### Font
- **Space Grotesk**

### Scale
| Token | Size | Weight | Usage |
|---|---|---|---|
| `displayLarge` | 32px | 700 | "LearnBack" splash |
| `headingLarge` | 26px | 600 | "Welcome", "Welcome Back" |
| `headingMedium` | 20px | 600 | "Create Your Account" |
| `headingSmall` | 16px | 600 | Section titles, card headers |
| `bodyLarge` | 16px | 400 | Skill names, body content |
| `bodyMedium` | 14px | 400 | Subtitles, descriptions |
| `bodySmall` | 12px | 400 | Taglines, helper text |
| `labelButton` | 16px | 600 | Button labels (white) |
| `labelLink` | 14px | 400 | Text links (blueLight #00F2FE) |
| `errorText` | 12px | 400 | Inline errors (red #FF4D6A) |

---

## 📐 Spacing Scale
```
XS:   4px
SM:   8px
MD:   16px
LG:   24px
XL:   32px
XXL:  48px
horizontalPadding: 24px (all screens)
```

---

## 🔘 Border Radius
```
inputField:   8px
button:       12px
card:         16px
modal:        20px
listItem:     12px
avatar:       circular
```

---

## 📦 Component Specs

### Primary Button — GradientButton widget
- Gradient: `#00F2FE → #7367F0`
- Height: 52px, full width
- Border radius: 12px
- Text: white, 16px, SemiBold (Space Grotesk)
- Loading state: white CircularProgressIndicator

### Text Link Button
- Background: transparent
- Text color: `#00F2FE` (dark) / `#00F2FE` (light)
- Font: 14px, Regular
- Examples: "Log In" (below CTA), "Back to login", "Forget Password?"

### Input Field
- Background: `#1E293B` (dark) / `#FFFFFF` (light)
- Border: 1px `#729EC9` (dark) / `#BCCCDC` (light)
- Focused border: 1.5px `#00F2FE`
- Error border: 1px `#FF4D6A`
- Border radius: 8px, Height: ~52px
- Padding: 16px horizontal
- Password field has eye toggle icon

### Skill List Item
- Background: `#1E293B`
- Border radius: 12px, Height: ~60px
- Left: name (white, SemiBold) + subtitle (`#8892B0`)
- Right: chevron `>` in `#00F2FE`
- Gap between items: 8px

### Error Text
- Appears below input field
- Color: `#FF4D6A`, 12px, Regular

---

## 📱 Device & Layout
- Design frame: iPhone 16 Plus (430 × 932pt)
- Horizontal padding: 24px (all screens)
- Safe area top: 59pt, bottom: 34pt

---

## 🖼️ Screens Identified So Far
| Screen | Frame | Notes |
|---|---|---|
| Splash Dark | 27 | Logo + tagline + "Get started" |
| Splash Light | 17 | Same layout, light palette |
| Login | 18 | Email + Password + "Log In" CTA |
| Register Step 1 | 19 | Name + Email + Password + Confirm |
| Register Step 2 (Skills) | 20 | Skill picker list |
| Email Confirmation | 33 | Envelope icon + "Resend email" |
| Login w/ Errors | 40 | Error states on inputs |
| Register w/ Errors | 41 | "Incorrect password" / "email already registered" |

---

## ⚠️ Rules for AI (Antigravity)
- Default theme is **dark mode** (`#0A192F` background).
- Both light and dark themes supported from day one.
- **Never hardcode hex values** in widgets — always use `AppColors.*` tokens.
- **Never hardcode font sizes** — always use `AppTextStyles.*`.
- **Never hardcode spacing** — use `AppTheme.spacing*` constants.
- Error messages go **below the input**, 12px, `#FF4D6A`.
- The logo is an SVG/PNG asset — never recreate it programmatically.
- Screens not yet in Figma must strictly follow this color system.
- Font is **Space Grotesk** — no substitutions.