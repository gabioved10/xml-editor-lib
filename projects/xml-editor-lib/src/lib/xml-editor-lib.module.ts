import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { EditorModule } from '@tinymce/tinymce-angular'; // 👈 חובה
import { XmlEditorLibComponent } from './xml-editor-lib.component';

@NgModule({
  declarations: [XmlEditorLibComponent],
  imports: [CommonModule, EditorModule],
  exports: [XmlEditorLibComponent]
})
export class XmlEditorLibModule {}
