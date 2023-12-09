import express from 'express';
import cors from 'cors';
import { TTScraper } from "tiktok-scraper-ts";
import fs from 'fs';
import 'dotenv/config'

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
    //verify exist file cookies.txt
    let cookiefile = undefined
    
    const r = await fetch(`${process.env.API_URL}/socials/accounts/tiktok`, {
        //@ts-ignore
        headers:{
            "X-Encryption-Key": process.env.APP_KEY,
        }
    })

    const accounts = await r.json()
    //select random account
    const account = accounts[Math.floor(Math.random() * accounts.length)];

    if(account.cookies)
    {
        fs.writeFileSync('./cookies.txt', account.cookies)
        cookiefile = './cookies.txt'
    }
    
    const scraper = new TTScraper(cookiefile)
    const data = await scraper.user(username);
    res.send(data)
})


app.listen(3050, () => {
    console.log('Server running on port 3050');
});