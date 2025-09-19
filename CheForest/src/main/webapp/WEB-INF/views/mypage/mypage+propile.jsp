<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
    <link rel="stylesheet" href="css/admin.css" />
    <link rel="stylesheet" href="css/globals.css" />
  </head>
  <body>
    <main>
      <div class="min-h-screen bg-gray-50">
        <div
          class="bg-gradient-to-r from-pink-50 to-orange-50 border-b border-orange-200"
        >
          <div class="max-w-6xl mx-auto px-4 py-8">
            <div class="flex items-center justify-between">
              <div class="flex items-center space-x-6">
                <span
                  data-slot="avatar"
                  class="relative flex size-10 shrink-0 overflow-hidden rounded-full w-20 h-20 ring-4 ring-orange-300"
                  ><img
                    data-slot="avatar-image"
                    class="aspect-square size-full"
                    src="https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=80&amp;h=80&amp;fit=crop&amp;crop=face"
                /></span>
                <div>
                  <h1 class="text-2xl font-medium mb-2">요리마스터</h1>
                  <div class="flex items-center space-x-4 mb-2">
                    <span
                      data-slot="badge"
                      class="inline-flex items-center justify-center rounded-md px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&amp;&gt;svg]:size-3 gap-1 [&amp;&gt;svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden border-transparent [a&amp;]:hover:bg-primary/90 bg-purple-100 text-purple-600 border-0"
                      >🌳 나무</span
                    ><span class="text-gray-600">가입일: 2023년 3월 15일</span>
                  </div>
                  <div class="flex items-center space-x-2">
                    <span class="text-sm text-gray-600">다음 등급까지</span>
                    <div
                      aria-valuemax="100"
                      aria-valuemin="0"
                      role="progressbar"
                      data-state="indeterminate"
                      data-max="100"
                      data-slot="progress"
                      class="bg-primary/20 relative overflow-hidden rounded-full w-32 h-2"
                    >
                      <div
                        data-state="indeterminate"
                        data-max="100"
                        data-slot="progress-indicator"
                        class="bg-primary h-full w-full flex-1 transition-all"
                        style="transform: translateX(-25%)"
                      ></div>
                    </div>
                    <span class="text-sm text-orange-600">75%</span>
                  </div>
                </div>
              </div>
              <button
                data-slot="button"
                class="inline-flex items-center justify-center gap-2 whitespace-nowrap rounded-md text-sm font-medium transition-all disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg:not([class*='size-'])]:size-4 shrink-0 [&amp;_svg]:shrink-0 outline-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive text-primary-foreground h-9 px-4 py-2 has-[&gt;svg]:px-3 bg-orange-500 hover:bg-gradient-to-r hover:from-pink-500 hover:to-orange-500"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="lucide lucide-settings w-4 h-4 mr-2"
                  aria-hidden="true"
                >
                  <path
                    d="M9.671 4.136a2.34 2.34 0 0 1 4.659 0 2.34 2.34 0 0 0 3.319 1.915 2.34 2.34 0 0 1 2.33 4.033 2.34 2.34 0 0 0 0 3.831 2.34 2.34 0 0 1-2.33 4.033 2.34 2.34 0 0 0-3.319 1.915 2.34 2.34 0 0 1-4.659 0 2.34 2.34 0 0 0-3.32-1.915 2.34 2.34 0 0 1-2.33-4.033 2.34 2.34 0 0 0 0-3.831A2.34 2.34 0 0 1 6.35 6.051a2.34 2.34 0 0 0 3.319-1.915"
                  ></path>
                  <circle cx="12" cy="12" r="3"></circle></svg
                >설정
              </button>
            </div>
          </div>
        </div>
        <div class="max-w-6xl mx-auto px-4 py-6">
          <div class="grid grid-cols-2 md:grid-cols-4 gap-4 mb-8">
            <div
              data-slot="card"
              class="text-card-foreground flex flex-col gap-6 rounded-xl border bg-gradient-to-br from-orange-50 to-pink-50 border-orange-200"
            >
              <div
                data-slot="card-content"
                class="[&amp;:last-child]:pb-6 p-4 text-center"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="lucide lucide-chef-hat w-6 h-6 mx-auto mb-2 text-orange-600"
                  aria-hidden="true"
                >
                  <path
                    d="M17 21a1 1 0 0 0 1-1v-5.35c0-.457.316-.844.727-1.041a4 4 0 0 0-2.134-7.589 5 5 0 0 0-9.186 0 4 4 0 0 0-2.134 7.588c.411.198.727.585.727 1.041V20a1 1 0 0 0 1 1Z"
                  ></path>
                  <path d="M6 17h12"></path>
                </svg>
                <div class="text-2xl font-medium text-orange-600">24</div>
                <div class="text-sm text-gray-600">작성한 레시피</div>
              </div>
            </div>
            <div
              data-slot="card"
              class="text-card-foreground flex flex-col gap-6 rounded-xl border bg-gradient-to-br from-pink-50 to-orange-50 border-pink-200"
            >
              <div
                data-slot="card-content"
                class="[&amp;:last-child]:pb-6 p-4 text-center"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="lucide lucide-message-square w-6 h-6 mx-auto mb-2 text-pink-600"
                  aria-hidden="true"
                >
                  <path
                    d="M22 17a2 2 0 0 1-2 2H6.828a2 2 0 0 0-1.414.586l-2.202 2.202A.71.71 0 0 1 2 21.286V5a2 2 0 0 1 2-2h16a2 2 0 0 1 2 2z"
                  ></path>
                </svg>
                <div class="text-2xl font-medium text-pink-600">156</div>
                <div class="text-sm text-gray-600">작성한 댓글</div>
              </div>
            </div>
            <div
              data-slot="card"
              class="text-card-foreground flex flex-col gap-6 rounded-xl border bg-gradient-to-br from-red-50 to-pink-50 border-red-200"
            >
              <div
                data-slot="card-content"
                class="[&amp;:last-child]:pb-6 p-4 text-center"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="lucide lucide-heart w-6 h-6 mx-auto mb-2 text-red-600"
                  aria-hidden="true"
                >
                  <path
                    d="M2 9.5a5.5 5.5 0 0 1 9.591-3.676.56.56 0 0 0 .818 0A5.49 5.49 0 0 1 22 9.5c0 2.29-1.5 4-3 5.5l-5.492 5.313a2 2 0 0 1-3 .019L5 15c-1.5-1.5-3-3.2-3-5.5"
                  ></path>
                </svg>
                <div class="text-2xl font-medium text-red-600">1847</div>
                <div class="text-sm text-gray-600">받은 좋아요</div>
              </div>
            </div>
            <div
              data-slot="card"
              class="text-card-foreground flex flex-col gap-6 rounded-xl border bg-gradient-to-br from-blue-50 to-indigo-50 border-blue-200"
            >
              <div
                data-slot="card-content"
                class="[&amp;:last-child]:pb-6 p-4 text-center"
              >
                <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="24"
                  height="24"
                  viewBox="0 0 24 24"
                  fill="none"
                  stroke="currentColor"
                  stroke-width="2"
                  stroke-linecap="round"
                  stroke-linejoin="round"
                  class="lucide lucide-eye w-6 h-6 mx-auto mb-2 text-blue-600"
                  aria-hidden="true"
                >
                  <path
                    d="M2.062 12.348a1 1 0 0 1 0-.696 10.75 10.75 0 0 1 19.876 0 1 1 0 0 1 0 .696 10.75 10.75 0 0 1-19.876 0"
                  ></path>
                  <circle cx="12" cy="12" r="3"></circle>
                </svg>
                <div class="text-2xl font-medium text-blue-600">12,453</div>
                <div class="text-sm text-gray-600">총 조회수</div>
              </div>
            </div>
          </div>
          <div
            dir="ltr"
            data-orientation="horizontal"
            data-slot="tabs"
            class="flex flex-col gap-2 w-full"
          >
            <div
              role="tablist"
              aria-orientation="horizontal"
              data-slot="tabs-list"
              class="bg-muted text-muted-foreground h-9 items-center justify-center rounded-xl p-[3px] grid w-full grid-cols-5 mb-8"
              tabindex="0"
              data-orientation="horizontal"
              style="outline: none"
            >
              <button
                type="button"
                role="tab"
                aria-selected="true"
                aria-controls="radix-:r1n:-content-profile"
                data-state="active"
                id="radix-:r1n:-trigger-profile"
                data-slot="tabs-trigger"
                class="data-[state=active]:bg-card dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-xl border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg]:shrink-0 [&amp;_svg:not([class*='size-'])]:size-4"
                tabindex="-1"
                data-orientation="horizontal"
                data-radix-collection-item=""
              >
                프로필</button
              ><button
                type="button"
                role="tab"
                aria-selected="false"
                aria-controls="radix-:r1n:-content-recipes"
                data-state="inactive"
                id="radix-:r1n:-trigger-recipes"
                data-slot="tabs-trigger"
                class="data-[state=active]:bg-card dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-xl border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg]:shrink-0 [&amp;_svg:not([class*='size-'])]:size-4"
                tabindex="-1"
                data-orientation="horizontal"
                data-radix-collection-item=""
              >
                내 레시피</button
              ><button
                type="button"
                role="tab"
                aria-selected="false"
                aria-controls="radix-:r1n:-content-comments"
                data-state="inactive"
                id="radix-:r1n:-trigger-comments"
                data-slot="tabs-trigger"
                class="data-[state=active]:bg-card dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-xl border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg]:shrink-0 [&amp;_svg:not([class*='size-'])]:size-4"
                tabindex="-1"
                data-orientation="horizontal"
                data-radix-collection-item=""
              >
                내 댓글</button
              ><button
                type="button"
                role="tab"
                aria-selected="false"
                aria-controls="radix-:r1n:-content-liked"
                data-state="inactive"
                id="radix-:r1n:-trigger-liked"
                data-slot="tabs-trigger"
                class="data-[state=active]:bg-card dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-xl border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg]:shrink-0 [&amp;_svg:not([class*='size-'])]:size-4"
                tabindex="-1"
                data-orientation="horizontal"
                data-radix-collection-item=""
              >
                좋아요</button
              ><button
                type="button"
                role="tab"
                aria-selected="false"
                aria-controls="radix-:r1n:-content-settings"
                data-state="inactive"
                id="radix-:r1n:-trigger-settings"
                data-slot="tabs-trigger"
                class="data-[state=active]:bg-card dark:data-[state=active]:text-foreground focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:outline-ring dark:data-[state=active]:border-input dark:data-[state=active]:bg-input/30 text-foreground dark:text-muted-foreground inline-flex h-[calc(100%-1px)] flex-1 items-center justify-center gap-1.5 rounded-xl border border-transparent px-2 py-1 text-sm font-medium whitespace-nowrap transition-[color,box-shadow] focus-visible:ring-[3px] focus-visible:outline-1 disabled:pointer-events-none disabled:opacity-50 [&amp;_svg]:pointer-events-none [&amp;_svg]:shrink-0 [&amp;_svg:not([class*='size-'])]:size-4"
                tabindex="-1"
                data-orientation="horizontal"
                data-radix-collection-item=""
              >
                설정
              </button>
            </div>
            <div
              data-state="active"
              data-orientation="horizontal"
              role="tabpanel"
              aria-labelledby="radix-:r1n:-trigger-profile"
              id="radix-:r1n:-content-profile"
              tabindex="0"
              data-slot="tabs-content"
              class="flex-1 outline-none space-y-6"
              style="animation-duration: 0s"
            >
              <div
                data-slot="card"
                class="bg-card text-card-foreground flex flex-col gap-6 rounded-xl border"
              >
                <div
                  data-slot="card-header"
                  class="@container/card-header grid auto-rows-min grid-rows-[auto_auto] items-start gap-1.5 px-6 pt-6 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6"
                >
                  <h4
                    data-slot="card-title"
                    class="leading-none flex items-center space-x-2"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="24"
                      height="24"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class="lucide lucide-award w-5 h-5 text-orange-600"
                      aria-hidden="true"
                    >
                      <path
                        d="m15.477 12.89 1.515 8.526a.5.5 0 0 1-.81.47l-3.58-2.687a1 1 0 0 0-1.197 0l-3.586 2.686a.5.5 0 0 1-.81-.469l1.514-8.526"
                      ></path>
                      <circle cx="12" cy="8" r="6"></circle></svg
                    ><span>등급 현황</span>
                  </h4>
                </div>
                <div
                  data-slot="card-content"
                  class="px-6 [&amp;:last-child]:pb-6"
                >
                  <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                      <h3 class="font-medium mb-4">현재 등급</h3>
                      <div class="p-4 rounded-lg bg-purple-100 text-center">
                        <div class="text-4xl mb-2">🌳</div>
                        <div class="text-xl font-medium text-purple-600">
                          나무
                        </div>
                        <div class="text-sm text-gray-600 mt-1">
                          레시피 24개 작성
                        </div>
                      </div>
                    </div>
                    <div>
                      <h3 class="font-medium mb-4">다음 등급</h3>
                      <div class="p-4 rounded-lg bg-pink-100 text-center">
                        <div class="text-4xl mb-2">🌲</div>
                        <div class="text-xl font-medium text-pink-600">숲</div>
                        <div class="text-sm text-gray-600 mt-1">
                          레시피 26개 더 필요
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
              <div
                data-slot="card"
                class="bg-card text-card-foreground flex flex-col gap-6 rounded-xl border"
              >
                <div
                  data-slot="card-header"
                  class="@container/card-header grid auto-rows-min grid-rows-[auto_auto] items-start gap-1.5 px-6 pt-6 has-data-[slot=card-action]:grid-cols-[1fr_auto] [.border-b]:pb-6"
                >
                  <h4
                    data-slot="card-title"
                    class="leading-none flex items-center space-x-2"
                  >
                    <svg
                      xmlns="http://www.w3.org/2000/svg"
                      width="24"
                      height="24"
                      viewBox="0 0 24 24"
                      fill="none"
                      stroke="currentColor"
                      stroke-width="2"
                      stroke-linecap="round"
                      stroke-linejoin="round"
                      class="lucide lucide-trending-up w-5 h-5 text-orange-600"
                      aria-hidden="true"
                    >
                      <path d="M16 7h6v6"></path>
                      <path d="m22 7-8.5 8.5-5-5L2 17"></path></svg
                    ><span>활동 현황</span>
                  </h4>
                </div>
                <div
                  data-slot="card-content"
                  class="px-6 [&amp;:last-child]:pb-6"
                >
                  <div class="space-y-4">
                    <div class="flex justify-between items-center">
                      <span>이번 달 레시피 작성</span
                      ><span
                        data-slot="badge"
                        class="inline-flex items-center justify-center rounded-md border px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&amp;&gt;svg]:size-3 gap-1 [&amp;&gt;svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden text-foreground [a&amp;]:hover:bg-accent [a&amp;]:hover:text-accent-foreground"
                        >3개</span
                      >
                    </div>
                    <div class="flex justify-between items-center">
                      <span>이번 달 댓글 작성</span
                      ><span
                        data-slot="badge"
                        class="inline-flex items-center justify-center rounded-md border px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&amp;&gt;svg]:size-3 gap-1 [&amp;&gt;svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden text-foreground [a&amp;]:hover:bg-accent [a&amp;]:hover:text-accent-foreground"
                        >15개</span
                      >
                    </div>
                    <div class="flex justify-between items-center">
                      <span>평균 레시피 조회수</span
                      ><span
                        data-slot="badge"
                        class="inline-flex items-center justify-center rounded-md border px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&amp;&gt;svg]:size-3 gap-1 [&amp;&gt;svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden text-foreground [a&amp;]:hover:bg-accent [a&amp;]:hover:text-accent-foreground"
                        >518회</span
                      >
                    </div>
                    <div class="flex justify-between items-center">
                      <span>평균 좋아요 수</span
                      ><span
                        data-slot="badge"
                        class="inline-flex items-center justify-center rounded-md border px-2 py-0.5 text-xs font-medium w-fit whitespace-nowrap shrink-0 [&amp;&gt;svg]:size-3 gap-1 [&amp;&gt;svg]:pointer-events-none focus-visible:border-ring focus-visible:ring-ring/50 focus-visible:ring-[3px] aria-invalid:ring-destructive/20 dark:aria-invalid:ring-destructive/40 aria-invalid:border-destructive transition-[color,box-shadow] overflow-hidden text-foreground [a&amp;]:hover:bg-accent [a&amp;]:hover:text-accent-foreground"
                        >77개</span
                      >
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div
              data-state="inactive"
              data-orientation="horizontal"
              role="tabpanel"
              aria-labelledby="radix-:r1n:-trigger-recipes"
              hidden=""
              id="radix-:r1n:-content-recipes"
              tabindex="0"
              data-slot="tabs-content"
              class="flex-1 outline-none space-y-4"
            ></div>
            <div
              data-state="inactive"
              data-orientation="horizontal"
              role="tabpanel"
              aria-labelledby="radix-:r1n:-trigger-comments"
              hidden=""
              id="radix-:r1n:-content-comments"
              tabindex="0"
              data-slot="tabs-content"
              class="flex-1 outline-none space-y-4"
            ></div>
            <div
              data-state="inactive"
              data-orientation="horizontal"
              role="tabpanel"
              aria-labelledby="radix-:r1n:-trigger-liked"
              hidden=""
              id="radix-:r1n:-content-liked"
              tabindex="0"
              data-slot="tabs-content"
              class="flex-1 outline-none space-y-4"
            ></div>
            <div
              data-state="inactive"
              data-orientation="horizontal"
              role="tabpanel"
              aria-labelledby="radix-:r1n:-trigger-settings"
              hidden=""
              id="radix-:r1n:-content-settings"
              tabindex="0"
              data-slot="tabs-content"
              class="flex-1 outline-none space-y-6"
            ></div>
          </div>
        </div>
      </div>
    </main>
  </body>
</html>
