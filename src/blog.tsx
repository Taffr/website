import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import type { BlogPostJson } from './blogpost'

const BLOG_POSTS = [
  'first-post',
] as const


const getPostUrl
  = (post: string) => `https://storage.googleapis.com/st-website-files/blog-posts/${post}`

type BlogPostPreview = {
  title: string;
  date: string;
  post: string;
}

const BlogPostPreview = ({ post, title , date }: BlogPostPreview) => {
  const nav = useNavigate()
  return (
   <li>
    <a onClick={() => nav(`/blog/${post}`) }>
      <u>
        <h2>
          { title } | { date }
        </h2>
      </u>
    </a>
   </li>
  )
}

export const Blog = () => {
  const [ allPosts, setAllPosts ] = useState<BlogPostPreview[]>([])
  const [ isLoading, setIsLoading ] = useState(true)

  useEffect(() => {
    Promise.all(
      BLOG_POSTS.map((post) => 
        fetch(getPostUrl(post))
          .then((r) => r.json())
          .then((json: BlogPostJson) => ({ post, title: json.title, date: json.date}))
        )
    )
    .then(setAllPosts)
    .catch(console.error)
    .finally(() => setIsLoading(false))
  }, [])

  return (
    <div>
      <h1>
        Blog
      </h1>
      {
        isLoading && <p> Loading ... </p>
      }
      {
        !isLoading && (
          <ul>
            { allPosts.map((p) => <BlogPostPreview title={p.title} date={p.date} post={p.post}/>) }
          </ul>
        )
      }
    </div>
  )
}

