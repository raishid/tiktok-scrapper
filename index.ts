import express from 'express';
import cors from 'cors';
import { TTScraper } from "tiktok-scraper-ts";

const app = express();
app.use(cors());

app.get('/api/profile/tiktok', async (req, res) => {
    const { query } = req.query;
    if(query == undefined || query == null || query == '') {
        res.send({
            error: 'Missing query'
        })
        return
    }
    const username = query as string
    const scraper = new TTScraper()
    const data = await scraper.user(username);
    res.send(data)
})


app.listen(3050, () => {
    console.log('Server running on port 3050');
});