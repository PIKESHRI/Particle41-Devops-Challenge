const express = require('express');
const app = express();

app.set('trust proxy', true); // to get correct IP behind reverse proxies

app.get('/', (req, res) => {
    const ip = req.ip;
    const timestamp = new Date().toISOString();

    res.json({ timestamp, ip });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`SimpleTimeService running on port ${PORT}`);
});
