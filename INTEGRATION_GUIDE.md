# הוראות שילוב הספרייה

## 1. התקנת התלויות
```bash
npm install @tinymce/tinymce-angular tinymce
```

## 2. הוספת TinyMCE ל-angular.json
```json
"assets": [
  {
    "glob": "**/*",
    "input": "node_modules/tinymce",
    "output": "/tinymce/"
  }
]
```

## 3. שימוש בספרייה
```typescript
import { XmlEditorLibModule } from 'xml-editor-lib';

@NgModule({
  imports: [XmlEditorLibModule]
})
export class AppModule { }
```

```html
<lib-xml-editor-lib 
  [apiKey]="'your-tinymce-api-key'"
  [xmlContent]="xmlContent">
</lib-xml-editor-lib>
```

## 4. העתקת קבצי Assets
העתק את התיקיות הבאות לפרויקט היעד:
- `src/assets/css/` → `src/assets/css/`
- `src/assets/xslt/` → `src/assets/xslt/`