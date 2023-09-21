import express from 'express';
import cors from 'cors';
import { TTScraper } from "tiktok-scraper-ts";

const app = express();
app.use(cors());

app.get('/api/profile/tiktok', (req, res) => {
    console.log(req);
    
    /* const scraper = new TTScraper()
    scraper.user() */
    res.send('Hello World!')
})


app.listen(3050, () => {});