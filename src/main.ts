// 必要なパッケージをインポートする
import { GatewayIntentBits, Client, Partials, Message } from 'discord.js'
import dotenv from 'dotenv'

// .envファイルを読み込む
dotenv.config()

// Botで使うGatewayIntents、partials
const client = new Client({
  intents: [
    GatewayIntentBits.DirectMessages,
    GatewayIntentBits.Guilds,
    GatewayIntentBits.GuildMembers,
    GatewayIntentBits.GuildMessages,
    GatewayIntentBits.MessageContent,
  ],
  partials: [Partials.Message, Partials.Channel],
})

// Botがきちんと起動したか確認
client.once('ready', () => {
  console.log('Ready!')
  if (client.user != null) {
    console.log(client.user.tag)
  }
})

// (twitter|x).com にマッチするような投稿をvxtwitter.comに置換
client.on('messageCreate', async (message: Message) => {
  if (message.author.bot) return
  if (message.content?.match('/(twitter|x)\.com/')) {
    const fixMessage = message.content.replace(/(twitter|x)\.com/, 'vxtwitter.com')
    message.channel.send(fixMessage)
  }
})

// ボット作成時のトークンでDiscordと接続
client.login(process.env.TOKEN)
