# ArtEcho API 文档

> 完整的API接口说明，包含AI分析功能的详细文档

---

## 📋 概述

ArtEcho提供了一套完整的API接口，支持图像上传、AI分析、画廊管理等功能。

### 基础信息
- **Base URL**: `http://localhost:3000/api`
- **API Version**: `v1`
- **Content-Type**: `application/json`

### 认证方式
目前版本无需认证，后续将添加API Key机制。

---

## 🔍 图像分析API

### AI图像识别

**POST** `/api/v1/analyze`

分析上传的图像，提供专业的艺术品分析报告。

#### 请求参数

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| image | string | 是 | Base64编码的图像数据 |
| filename | string | 否 | 图像文件名 |
| options | object | 否 | 分析选项 |

#### 请求示例

```json
{
    "image": "data:image/jpeg;base64,/9j/4AAQSkZJRgABA...",
    "filename": "mona_lisa.jpg",
    "options": {
        "detailed": true,
        "include_history": true
    }
}
```

#### 响应示例

```json
{
    "success": true,
    "data": {
        "id": "analysis_12345",
        "title": "蒙娜丽莎",
        "artist": "列奥纳多·达·芬奇",
        "period": "文艺复兴时期",
        "style": "文艺复兴风格",
        "technique": "油画技法",
        "description": "世界上最著名的肖像画之一，以其神秘的微笑和精湛的绘画技艺闻名于世。",
        "features": [
            "神秘的微笑",
            "精湛的晕涂法",
            "完美的构图",
            "深邃的背景"
        ],
        "culturalValue": "代表了文艺复兴时期的艺术巅峰，是西方艺术史上的里程碑作品。",
        "historicalContext": "创作于1503-1519年间，现收藏于法国卢浮宫博物馆。",
        "confidence": "92.3%",
        "processingTime": "1.8秒",
        "analyzedAt": "2024-12-10T19:30:00Z"
    },
    "message": "分析完成"
}
```

#### 错误响应

```json
{
    "success": false,
    "error": {
        "code": "INVALID_IMAGE",
        "message": "图像格式不支持",
        "details": "仅支持JPEG、PNG格式"
    }
}
```

---

## 🖼️ 画廊管理API

### 获取画廊列表

**GET** `/api/v1/gallery`

获取用户的画廊图片列表。

#### 查询参数

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| page | integer | 否 | 页码，默认1 |
| limit | integer | 否 | 每页数量，默认20 |
| search | string | 否 | 搜索关键词 |
| source | string | 否 | 图片来源过滤 |
| sort | string | 否 | 排序字段，默认date |

#### 响应示例

```json
{
    "success": true,
    "data": {
        "photos": [
            {
                "id": "gallery_123",
                "title": "蒙娜丽莎分析",
                "description": "AI分析后的蒙娜丽莎",
                "dataUrl": "data:image/jpeg;base64,...",
                "date": "2024-12-10T19:30:00Z",
                "source": "upload",
                "fileSize": "245.7 KB",
                "aiAnalysis": {
                    "title": "蒙娜丽莎",
                    "artist": "列奥纳多·达·芬奇",
                    "confidence": "92.3%"
                }
            }
        ],
        "pagination": {
            "page": 1,
            "limit": 20,
            "total": 45,
            "totalPages": 3
        }
    }
}
```

### 添加图片到画廊

**POST** `/api/v1/gallery`

将新图片添加到画廊。

#### 请求参数

```json
{
    "title": "图片标题",
    "description": "图片描述",
    "dataUrl": "data:image/jpeg;base64,...",
    "source": "webcam|upload|mobile",
    "tags": ["标签1", "标签2"]
}
```

#### 响应示例

```json
{
    "success": true,
    "data": {
        "id": "gallery_456",
        "title": "新添加的图片",
        "createdAt": "2024-12-10T19:35:00Z"
    }
}
```

### 更新图片信息

**PUT** `/api/v1/gallery/{id}`

更新画廊中图片的信息。

#### 请求参数

```json
{
    "title": "更新后的标题",
    "description": "更新后的描述",
    "tags": ["新标签"]
}
```

### 删除图片

**DELETE** `/api/v1/gallery/{id}`

从画廊中删除指定图片。

#### 响应示例

```json
{
    "success": true,
    "message": "图片已删除"
}
```

---

## 📊 统计信息API

### 获取画廊统计

**GET** `/api/v1/gallery/stats`

获取画廊的统计信息。

#### 响应示例

```json
{
    "success": true,
    "data": {
        "totalPhotos": 156,
        "todayPhotos": 3,
        "storageSize": "12.4 MB",
        "sourceStats": {
            "webcam": 45,
            "upload": 89,
            "mobile": 22
        },
        "analyzedPhotos": 134,
        "avgConfidence": "87.2%"
    }
}
```

---

## 🔧 配置API

### 获取AI配置

**GET** `/api/v1/config/ai`

获取AI分析功能的配置信息。

#### 响应示例

```json
{
    "success": true,
    "data": {
        "supportedFormats": ["JPEG", "PNG", "WebP"],
        "maxFileSize": "10MB",
        "supportedArtworks": [
            "蒙娜丽莎",
            "星月夜",
            "戴珍珠耳环的少女"
        ],
        "modelVersion": "wenxin-4.0",
        "processingTime": {
            "min": "1.2s",
            "max": "3.5s",
            "avg": "2.1s"
        }
    }
}
```

---

## 🎯 批量操作API

### 批量分析

**POST** `/api/v1/batch/analyze`

批量分析多张图片。

#### 请求参数

```json
{
    "imageIds": ["img_1", "img_2", "img_3"],
    "options": {
        "priority": "normal|high",
        "notify": true
    }
}
```

#### 响应示例

```json
{
    "success": true,
    "data": {
        "batchId": "batch_789",
        "status": "processing",
        "totalImages": 3,
        "completedImages": 0,
        "estimatedTime": "6.3s"
    }
}
```

### 批量删除

**POST** `/api/v1/batch/delete`

批量删除画廊中的图片。

#### 请求参数

```json
{
    "photoIds": ["gallery_1", "gallery_2", "gallery_3"]
}
```

---

## 🔍 搜索API

### 搜索图片

**GET** `/api/v1/search`

在画廊中搜索图片。

#### 查询参数

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| q | string | 是 | 搜索关键词 |
| type | string | 否 | 搜索类型：title|description|all |
| filters | object | 否 | 过滤条件 |

#### 响应示例

```json
{
    "success": true,
    "data": {
        "results": [
            {
                "id": "gallery_123",
                "title": "蒙娜丽莎",
                "description": "达芬奇的代表作",
                "relevanceScore": 0.95,
                "highlight": "蒙娜<em>丽莎</em>"
            }
        ],
        "total": 12,
        "searchTime": "0.05s"
    }
}
```

---

## 📤 导出API

### 导出画廊数据

**GET** `/api/v1/export`

导出画廊数据为指定格式。

#### 查询参数

| 参数名 | 类型 | 必填 | 描述 |
|--------|------|------|------|
| format | string | 否 | 导出格式：json|csv|xlsx，默认json |
| includeAnalysis | boolean | 否 | 是否包含AI分析结果 |
| dateRange | object | 否 | 日期范围过滤 |

#### 响应

根据format参数返回相应格式的文件下载。

---

## 🚫 错误代码

| 错误代码 | HTTP状态 | 描述 |
|----------|----------|------|
| INVALID_REQUEST | 400 | 请求参数无效 |
| INVALID_IMAGE | 400 | 图像格式或大小不符合要求 |
| AI_SERVICE_ERROR | 503 | AI分析服务不可用 |
| RATE_LIMIT_EXCEEDED | 429 | 请求频率超限 |
| NOT_FOUND | 404 | 资源不存在 |
| INTERNAL_ERROR | 500 | 服务器内部错误 |

---

## 🔑 限制说明

### 请求限制
- **AI分析**：每分钟最多10次请求
- **文件上传**：单个文件最大10MB
- **批量操作**：每次最多处理50张图片

### 功能限制
- **支持格式**：JPEG、PNG、WebP
- **识别范围**：当前支持约50种著名艺术品
- **存储容量**：受浏览器LocalStorage限制

---

## 📚 SDK和工具

### JavaScript SDK

```javascript
// 初始化SDK
const ArtEcho = require('artecho-sdk');

// AI分析
const client = new ArtEcho.Client({
    baseURL: 'http://localhost:3000/api'
});

// 分析图片
const result = await client.ai.analyze({
    image: imageData,
    options: { detailed: true }
});

// 画廊管理
const photos = await client.gallery.list({
    search: '蒙娜丽莎'
});
```

### Python SDK

```python
from artecho import ArtEchoClient

# 初始化客户端
client = ArtEchoClient(base_url='http://localhost:3000/api')

# AI分析
result = client.ai.analyze(
    image=open('image.jpg', 'rb'),
    options={'detailed': True}
)

# 画廊操作
photos = client.gallery.list(search='蒙娜丽莎')
```

---

## 🧪 测试环境

### 测试端点

- **基础URL**: `http://localhost:3000/api/test`
- **测试数据**: `/api/test/fixtures`

### 示例请求

```bash
# 测试AI分析
curl -X POST http://localhost:3000/api/v1/analyze \
  -H "Content-Type: application/json" \
  -d '{"image": "data:image/jpeg;base64,..."}'

# 获取画廊列表
curl http://localhost:3000/api/v1/gallery

# 获取统计信息
curl http://localhost:3000/api/v1/gallery/stats
```

---

## ?? 监控和日志

### 健康检查

**GET** `/api/health`

检查API服务状态。

#### 响应示例

```json
{
    "status": "healthy",
    "timestamp": "2024-12-10T19:40:00Z",
    "version": "1.0.0",
    "services": {
        "ai": "healthy",
        "database": "healthy",
        "storage": "healthy"
    }
}
```

### 监控指标

- **响应时间**
- **错误率**
- **请求量**
- **AI分析成功率**

---

## 🔄 版本更新

### v1.0.0 (当前版本)
- 基础AI分析功能
- 画廊管理
- 搜索和筛选

### v1.1.0 (计划中)
- 批量操作增强
- 更多AI模型支持
- 高级搜索功能

---

## 📞 支持和反馈

### 技术支持
- **邮箱**: support@artecho.com
- **GitHub**: https://github.com/yanxuefengyan/Hackathon_ArtEcho/issues
- **文档**: https://docs.artecho.com

### API反馈
欢迎提交API使用反馈和建议，帮助我们改进服务。

---

> 通过标准化的API接口，让ArtEcho的功能更加开放和可扩展。
