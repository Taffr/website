import { useParams } from 'react-router-dom'
import { useEffect, useState } from 'react'

const getPostUrl
  = (post: string) => `https://storage.googleapis.com/st-website-files/blog-posts/${post}`

export type BlogPostJson = {
  title: string;
  date: string;
  body: string;
}

export const BlogPost = () => {
  const { post } = useParams()
  const [ blogPost, setBlogPost ] = useState<BlogPostJson | null>(null)
  const [ isLoading, setIsLoading] = useState(false)

  useEffect(() => {
    if (post) {
      fetch(getPostUrl(post)).then((r) => r.json())
        .then(setBlogPost)
        .catch(console.error)
        .finally(() => setIsLoading(false))
    }
  }, [])


  if (isLoading) {
    return (
      <div>
        <h1>
          Loading ...
        </h1>
      </div>
    )
  }

  if (!blogPost) {
    return (
      <div>
        <h1>
          Post not found ...
        </h1>
        <p>It might have been moved, renamed, or simply never existed ... </p>
      </div>
    )
  }

  return (
    <div>
      <h1>
        { blogPost.title}
      </h1>
      <h2>
        { blogPost.date }
      </h2>
      <p>
        { blogPost.body }
      </p>
    </div>
  )
}
