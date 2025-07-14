import { TestBed } from '@angular/core/testing';

import { XmlEditorLibService } from './xml-editor-lib.service';

describe('XmlEditorLibService', () => {
  let service: XmlEditorLibService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(XmlEditorLibService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
