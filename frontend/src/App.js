import React, { useEffect, useState } from 'react';

function App() {
  const [services, setServices] = useState([]);

  useEffect(() => {
    // API Gateway ద్వారా డేటాని పిలుస్తున్నాం
    fetch('/api/catalog/services')
      .then(res => res.json())
      .then(data => setServices(data))
      .catch(err => console.error("Error fetching services:", err));
  }, []);

  return (
    <div style={{ padding: '20px', fontFamily: 'Arial' }}>
      <h1>Welcome to Vedhan Sri Beauty Academy</h1>
      <h2>Our Services (Ladies Only)</h2>
      <ul>
        {Object.keys(services).map(category => (
          <li key={category}>
            <strong>{category}:</strong> {services[category].join(', ')}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default App;