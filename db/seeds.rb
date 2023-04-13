bio_text = "Hello, I'm an experienced professional with a strong background in technology and innovation. Over the years, I have honed my skills in software development, data analysis, and project management. I have a keen eye for detail and a deep passion for solving complex problems through creative solutions. I believe in continuous learning and staying up-to-date with the latest industry trends."

users_data = [
    {name: "Henry Murphy", bio: bio_text, photo: "https://randomuser.me/api/portraits/men/20.jpg"},
    {name: "Bill Meyer", bio: bio_text, photo: "https://randomuser.me/api/portraits/men/21.jpg"},
    {name: "Delores Matthews", bio: bio_text, photo: "https://randomuser.me/api/portraits/women/76.jpg"},
    {name: "Ronnie Gregory", bio: bio_text, photo: "https://randomuser.me/api/portraits/men/23.jpg"},
    {name: "Rita Ford", bio: bio_text, photo: "https://randomuser.me/api/portraits/women/24.jpg"},
]

posts_data = [
  { title: "The Art of Storytelling", text: "Storytelling is a powerful tool that has been used for centuries to convey messages, entertain, and inspire. Whether it's through books, movies, or oral traditions, stories have the ability to capture our imagination and connect with us on an emotional level. In this blog post, we'll explore the art of storytelling, its history, techniques, and impact on society."},
  { title: "The Science of Happiness", text: "Happiness is a complex and fascinating emotion that plays a significant role in our lives. But what exactly is happiness? How does it affect our well-being, and can it be measured? In this blog post, we'll dive into the science of happiness, exploring the latest research on the topic, the factors that contribute to our happiness, and practical tips on how to cultivate more happiness in our lives."},
  { title: "Mastering Time Management", text: "Time is a precious resource that we all have in equal measure, yet many of us struggle with managing it effectively. In this fast-paced world, it's essential to develop good time management skills to stay productive and achieve our goals. In this blog post, we'll delve into the art of mastering time management, including techniques, tools, and strategies to help you make the most out of your time."},
  { title: "The Power of Positive Thinking", text: "Our mindset and attitude play a significant role in shaping our lives and experiences. Positive thinking is a powerful tool that can help us overcome challenges, build resilience, and create a fulfilling life. In this blog post, we'll explore the power of positive thinking, its benefits, and practical tips on how to cultivate a positive mindset in your daily life."},
  { title: "Demystifying Artificial Intelligence", text: "Artificial Intelligence (AI) is a rapidly evolving field that has the potential to revolutionize industries and change the way we live and work. But what exactly is AI, and how does it work? In this blog post, we'll demystify artificial intelligence, exploring its history, applications, ethical considerations, and its impact on society."},
  { title: "The Future of Remote Work", text: "The COVID-19 pandemic has accelerated the adoption of remote work, and it's changing the way we work and collaborate. But what does the future hold for remote work beyond the pandemic? In this blog post, we'll explore the future of remote work, including its benefits, challenges, best practices, and its potential impact on the job market and work culture."},
]

comments_data = [
    "Great post! I enjoyed reading it and found the content to be informative and engaging.",
    "Interesting insights! Your perspective on the topic is thought-provoking and well-presented.",
    "Well done! Your writing style is captivating, and your ideas are well-organized and coherent.",
    "I appreciate the effort you put into this post. The information provided is valuable and useful.",
    "Awesome blog post! I learned something new and gained a different perspective from reading it.",
    "I love how you addressed the topic in depth. Your research and analysis are evident in your writing.",
    "This is a well-written piece with practical tips and actionable advice. Thank you for sharing!",
    "I found your post to be insightful and well-researched. It's clear that you put a lot of thought into it.",
    "Your writing is engaging and easy to follow. I enjoyed reading your post from start to finish.",
    "Great job! Your post is informative, engaging, and well-structured. Keep up the good work!"
]

users = []
posts = []

users_data.each do |data|
    users << User.create(data)
end 

users.each do |user|
    posts_data.each do |post|
        posts << Post.create(author: user, title: post[:title], text: post[:text])
    end
end

posts.each do |post|
    comments_data.shuffle.each { |text| Comment.create(author: users.sample, post: post, text: text) }
    rand(1..15).times { Like.create(author: users.sample, post: post) }
end

