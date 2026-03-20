export function Card({ title, subtitle, right, children, className = '', contentClassName = '' }) {
  return (
    <section className={`rounded-xl border border-zinc-200 bg-white ${className}`}>
      {(title || subtitle || right) && (
        <header className="flex items-start justify-between gap-3 border-b border-zinc-100 px-4 py-3 sm:px-5">
          <div className="min-w-0">
            {title ? <h2 className="text-lg font-semibold">{title}</h2> : null}
            {subtitle ? <p className="text-sm text-zinc-500">{subtitle}</p> : null}
          </div>
          {right}
        </header>
      )}
      <div className={`p-4 sm:p-5 ${contentClassName}`}>{children}</div>
    </section>
  )
}

