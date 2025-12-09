import React, { useState } from 'react';
import './App.css';

interface Artwork {
  id: string;
  title: string;
  artist: string;
  year: string;
  description: string;
  imageUrl: string;
}

const mockArtworks: Artwork[] = [
  {
    id: '1',
    title: '蒙娜丽莎',
    artist: '列奥纳多·达·芬奇',
    year: '1503-1519',
    description: '世界上最著名的肖像画之一，以其神秘的微笑而闻名。',
    imageUrl: 'https://picsum.photos/400/300?random=1'
  },
  {
    id: '2',
    title: '星夜',
    artist: '文森特·梵高',
    year: '1889',
    description: '后印象派绘画的代表作，展现了梵高独特的艺术风格。',
    imageUrl: 'https://picsum.photos/400/300?random=2'
  }
];

function App() {
  const [selectedArtwork, setSelectedArtwork] = useState<Artwork | null>(null);
  const [uploadedImage, setUploadedImage] = useState<string | null>(null);
  const [isAnalyzing, setIsAnalyzing] = useState(false);

  const handleImageUpload = (event: React.ChangeEvent<HTMLInputElement>) => {
    const file = event.target.files?.[0];
    if (file) {
      const reader = new FileReader();
      reader.onloadend = () => {
        setUploadedImage(reader.result as string);
        analyzeImage();
      };
      reader.readAsDataURL(file);
    }
  };

  const analyzeImage = () => {
    setIsAnalyzing(true);
    // 模拟图像分析过程
    setTimeout(() => {
      setSelectedArtwork(mockArtworks[0]);
      setIsAnalyzing(false);
    }, 2000);
  };

  const resetUpload = () => {
    setUploadedImage(null);
    setSelectedArtwork(null);
  };

  return (
    <div className="app">
      <header className="header">
        <h1>ArtEcho</h1>
        <p>AI-Powered Interactive Art Appreciation</p>
      </header>

      <main className="main-content">
        {!selectedArtwork ? (
          <div className="upload-section">
            <div className="upload-card">
              <h2>上传或拍摄名画</h2>
              <p>支持多种图片格式，AI将为您识别并解析</p>
              
              <div className="upload-area">
                <input
                  type="file"
                  id="image-upload"
                  accept="image/*"
                  onChange={handleImageUpload}
                  className="file-input"
                />
                <label htmlFor="image-upload" className="upload-label">
                  <div className="upload-icon">📷</div>
                  <span>点击上传图片</span>
                </label>
              </div>

              {uploadedImage && (
                <div className="uploaded-preview">
                  <img src={uploadedImage} alt="Uploaded artwork" />
                  <button onClick={resetUpload} className="reset-btn">重新上传</button>
                </div>
              )}

              {isAnalyzing && (
                <div className="analyzing">
                  <div className="spinner"></div>
                  <p>AI正在分析名画...</p>
                </div>
              )}
            </div>

            <div className="sample-artworks">
              <h3>示例名画</h3>
              <div className="artwork-grid">
                {mockArtworks.map((artwork) => (
                  <div
                    key={artwork.id}
                    className="artwork-card"
                    onClick={() => setSelectedArtwork(artwork)}
                  >
                    <img src={artwork.imageUrl} alt={artwork.title} />
                    <h4>{artwork.title}</h4>
                    <p>{artwork.artist}</p>
                  </div>
                ))}
              </div>
            </div>
          </div>
        ) : (
          <div className="artwork-detail">
            <button onClick={resetUpload} className="back-btn">← 返回</button>
            
            <div className="artwork-info">
              <div className="artwork-image">
                <img src={selectedArtwork.imageUrl} alt={selectedArtwork.title} />
              </div>
              
              <div className="artwork-content">
                <h2>{selectedArtwork.title}</h2>
                <p className="artist-info">
                  {selectedArtwork.artist} · {selectedArtwork.year}
                </p>
                
                <div className="description">
                  <h3>作品描述</h3>
                  <p>{selectedArtwork.description}</p>
                </div>

                <div className="ai-analysis">
                  <h3>AI 智能解析</h3>
                  <div className="analysis-content">
                    <p><strong>艺术风格：</strong> 文艺复兴时期</p>
                    <p><strong>创作背景：</strong> 这幅画创作于意大利文艺复兴全盛时期</p>
                    <p><strong>艺术价值：</strong> 代表了人文主义思想的兴起</p>
                  </div>
                </div>

                <div className="action-buttons">
                  <button className="btn-primary">🎵 听讲解</button>
                  <button className="btn-secondary">🎬 3D展示</button>
                  <button className="btn-secondary">💾 收藏</button>
                </div>
              </div>
            </div>
          </div>
        )}
      </main>

      <footer className="footer">
        <p>&copy; 2025 ArtEcho - 让艺术活起来</p>
      </footer>
    </div>
  );
}

export default App;