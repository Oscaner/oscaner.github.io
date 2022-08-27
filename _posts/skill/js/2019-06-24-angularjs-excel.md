---
layout: post
title: "AngularJS 实现 Excel 导入导出"
date: 2019-06-24 23:12
author: "Oscaner"
header-img: "assets/img/post-bg-alitrip.jpg"
multilingual: false
mathjax: false
no-catalog: false
categories:
  - skill
  - angularjs
tags:
  - Skill
  - AngularJS
---

由于 AngularJS 属于前端框架, 用官方的话说, 浏览器端不应该有读写文件的权限

因此类似于 `fs` 这一类的 `nodejs` 内置模块都是被屏蔽的

想要实现 Excel 导入导出需要另辟捷径

## 实现

`excel.service.ts` 文件

需要安装 `XLSX` package: `npm i --save xlsx`

```javascript
import { Injectable } from '@angular/core';
import * as XLSX from 'xlsx';

const excel = {
    type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=UTF-8',
    extension: 'xlsx',
    fileAccept: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet',
};

export abstract class ExcelModel {
    abstract export(json: any[], fileName: string): void;
    abstract read(file: Blob): Promise<any>;
}

@Injectable()
export class ExcelService extends ExcelModel {
    constructor() {
        super();
    }

    export(json: any[], fileName: string): void {
        const worksheet: XLSX.WorkSheet = XLSX.utils.json_to_sheet(json);
        const workbook = XLSX.utils.book_new();
        XLSX.utils.book_append_sheet(workbook, worksheet, fileName);
        const fullName = `${fileName}_export_${new Date().getTime()}.${excel.extension}`;
        XLSX.writeFile(workbook, fullName);
    }

    read(file: Blob): Promise<any> {
        const reader = new FileReader();
        reader.readAsBinaryString(file);
        const json_object = {};
        return new Promise({resolve, reject} => {
            reader.onload = function() {
                const data = reader.result;
                const workbook = XLSX.read(data, {type: 'binary'});
                workbook.SheetNames.forEach((sheetName) => {
                    const xl_row_object = XLSX.utils.sheet_to_json(workbook.Sheets[sheetName]);
                    json_object[sheetName] = JSON.stringify(xl_row_object);
                });
                return resolve(json_object);
            };
        });
    }
}
```

## 使用

Ex. `path.component.ts`

```javascript
import { Component } from '@angular/core';
import { ExcelService } from '{path}/excel.service';

@Component({
    selector: 'ngx-path',
    templateUrl: './path.component.html',
    styleUrls: ['./path.component.scss'],
})
export class PathComponent {
    constructor(private excel: ExcelService) {}

    onExportConfirm(): void {
        const message = 'Are you sure you want to export all paths?';
        if (window.confirm(message)) {
            this.path.getAll()
                .subscribe(
                    (response) => {
                        this.excel.export(response.data, 'sitemap');
                    },
                );
        }
    }

    onReadConfirm(event): void {
        this.excel.read(event.target.files[0])
            .then((result) => {
                console.log(result);
            });
    }
}
```
